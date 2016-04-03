module Songable
	require 'open-uri'
  def list_query_results(query)
  	puts "These are query results"
  	query.gsub!(' ', '-')
  	doc = Nokogiri::HTML(open("http://genius.com/search?q=#{query}"))

		#I think this has same effect as #each_with_object([]) James?
  	choices = doc.css('li.search_result').to_a 
  end

end