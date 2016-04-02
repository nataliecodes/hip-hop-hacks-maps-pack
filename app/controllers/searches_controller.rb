class SearchesController < ApplicationController
	include Songable
	
	def index
		@search_results = "Hello"
	end

	def create
		query = params[:"song-query"]
		#song_list = genius_query_list(song_query) James scrape method

		binding.pry
	end
end
