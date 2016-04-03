class Tag
  attr_reader :word
  def initialize args={}
    @word = args[:word]
    @location = args[:location]
    @noun = args[:noun]
    @num = args[:num]
  end
  def ignore?
    !location? && !noun? && !num?
  end
  def location?
    @location
  end
  def noun?
    @noun && !@location
  end
  def num?
    @num
  end
end
module LocationsParser 
  Rjb::load('lib/stanford-postagger.jar:lib/stanford-ner.jar', ['-Xmx200m'])
  CRFClassifier = Rjb::import('edu.stanford.nlp.ie.crf.CRFClassifier')
  Classifier = CRFClassifier.getClassifierNoExceptions("lib/ner-eng-ie.crf-4-conll.ser.gz")
  MaxentTagger = Rjb::import('edu.stanford.nlp.tagger.maxent.MaxentTagger')
  MaxentTagger.init("lib/left3words-wsj-0-18.tagger")
  def get_locations_from_lyrics string
    tags = string.split(" ").map do |word|
      Tag.new(:word=> word, :noun => noun?(word), :num=> num?(word), :location => location?(word))
    end
    get_locations tags
  end
  def get_locations tags
    num_count, noun_count = 0, 0
    result = []
    locations = tags.each_with_object([]) do |tag, loc_array|
      if tag.ignore?
        loc_array << loc_str(result) unless result.empty? 
        num_count, noun_count = 0, 0
      end
      num_count+=1 if tag.num?
      noun_count+=1 if tag.noun?
      if num_count > 1 
        loc_array << loc_str(result) unless result.empty?
        num_count, noun_count = 1, 0
      end
      if noun_count > 3
        loc_array << loc_str(result) unless result.empty?
        num_count, noun_count = 0, 1 
      end
      if tag.num? || tag.noun? || tag.location?
        result << tag
      end
    end
    locations << loc_str(result)
    locations.delete_if(&:nil?)
    locations.uniq
  end
  private
  def location? word
    Classifier.testString( word ).split("/").last == "LOCATION "
  end
  def noun? word
    MaxentTagger.tagString( word ).split("/").last == "NNP " 
  end
  def num? word
    MaxentTagger.tagString( word ).split("/").last == "CD "
  end
  def has_non_alpha tag 
    valid_chars = [*?a..?z, *?A..?Z, *'0'..'9']
    a = tag.word.chars
    !(a == a & valid_chars)
  end
  def num_only_in_beginning result
    a = result.dup
    a.shift
    a.none?(&:num?)
  end
  def disqualified result
    (result.length == 1) && result.none?(&:location?) || 
      result.all?(&:num?) ||
      result.any? {|t| has_non_alpha(t) } ||
      !num_only_in_beginning(result)
  end
  def loc_str result
    str = result.map(&:word).join(" ") unless disqualified(result)
    result.clear
    str
  end
end
