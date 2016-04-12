class MapsController < ApplicationController
  include LocationsParser
  include Songable
  GEOCODE_URI = "https://maps.googleapis.com/maps/api/geocode/json"

  def index
    @api_key = API_KEY
  end

  def create_query
    query = params[:"song-query"]
    @query_results = list_query_results(query)
    render 'index'
  end

  def create ##change this and the link that posts to it in /app/views/songs/index.html.erb
    lyrics = get_lyrics_from_link(params[:url])
    @locations = get_locations_from_lyrics(lyrics)  
    # @locations = "New York"
    if request.xhr?

      #### Below returns an array of geocoded locations in JSON notation I think. Currently returns array of JSON Objects.
      response = @locations.map do |location|
        HTTParty.get(GEOCODE_URI, {query: {address: location, key: ENV["GOOGLE_MAPS_API_KEY"]}})
      end
      marker_positions = get_array_of_positions_from_response response
      render json: {
        marker_positions: marker_positions
      }
    end
  end

  private

  def get_array_of_positions_from_response response
    response.first["results"].map do |result|  ###### NEED to get it to work with multiple locations, response.first is just a hack
      result["geometry"]["location"]
    end
  end
end
