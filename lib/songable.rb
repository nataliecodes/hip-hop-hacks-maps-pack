module Songable
  require 'open-uri'
  def list_query_results(query)
    puts "These are query results"
    query.gsub!(' ', '-')
    doc = Nokogiri::HTML(open("http://genius.com/search?q=#{query}"))
    doc.css('li.search_result').map do |result|
      Hash[:text, result.content.delete("\n"),
           :url, result.children[1].attributes['href'].value]
    end
  end

end
