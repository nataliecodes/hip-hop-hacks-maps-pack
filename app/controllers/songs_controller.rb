class SongsController < ApplicationController
	include Songable

	def index
		@search_results = "Hello"
	end

	def create
		query = params[:"song-query"]
		@query_results = list_query_results(query)

		render 'index'
	end
end
