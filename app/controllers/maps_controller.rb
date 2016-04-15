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

  def create
    lyrics = get_lyrics_from_link(params[:url])
    lyrics_by_line = lyrics.split("\n")
    @new_locations = get_locations_from_lyrics_DB(lyrics)
    # @locations = get_locations_from_lyrics_NER(lyrics)
    if request.xhr?

      response = @new_locations.map do |location|
        HTTParty.get(GEOCODE_URI, {query: {address: location, key: ENV["GOOGLE_MAPS_API_KEY"]}})
      end
      marker_positions = get_array_of_positions_from_response response
      render json: {
        marker_positions: marker_positions,
        lyrics: lyrics_by_line
      }
    end
  end

  private

  def get_array_of_positions_from_response response
    positions = []
    response.each do |location|
      location["results"].map do |result|
        positions << result["geometry"]["location"]
      end
    end
    positions
  end
end