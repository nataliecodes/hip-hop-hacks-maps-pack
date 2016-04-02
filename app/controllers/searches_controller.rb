class SearchesController < ApplicationController
	def index
		@search_results = "Hello"
	end

	def create
		song_query = params[:"song-query"]
		#song_list = genius_query_list(song_query) James scrape method
		
	end
end
