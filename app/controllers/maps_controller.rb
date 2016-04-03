class MapsController < ApplicationController
  include LocationsParser
  include Songable
  GEOCODE_URI = "https://maps.googleapis.com/maps/api/geocode/json"

	def index
		
	end
  def create ##change this and the link that posts to it in /app/views/songs/index.html.erb
    lyrics = get_lyrics_from_link(params[:url])
    @locations = get_locations_from_lyrics(lyrics)
    render "maps/test"
  end
  def geocode_search
    response = HTTParty.get(GEOCODE_URI, {address: params[:query], key: ENV["GOOGLE_MAPS_API_KEY"]})
    @marker_positions = response["results"].map do |result|
      return result["geometry"]["location"]
    end
    render json: {html: render_to_string("maps/_map", layout: false, locals: {api_key: API_KEY})}
  end
end
