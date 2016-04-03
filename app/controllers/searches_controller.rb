class SearchesController < ApplicationController
	include Songable

	def index
		@search_results = "Hello"
	end

	def create
		query = params[:"song-query"]
		#song_list = genius_query_list(song_query) James scrape method
		@query_results = list_query_results(query)

		render 'index'
	end
end
