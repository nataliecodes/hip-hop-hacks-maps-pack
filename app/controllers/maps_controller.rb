class MapsController < ApplicationController
  GEOCODE_URI = "https://maps.googleapis.com/maps/api/geocode/json"

	def index
		
	end

  def geocode_search
    response = HTTParty.get(GEOCODE_URI, {address: params[:query], key: ENV["GOOGLE_MAPS_API_KEY"]})
    @marker_positions = response["results"].map do |result|
      return result["geometry"]["location"]
    end
    render json: {html: render_to_string("maps/_map", layout: false, locals: {api_key: API_KEY})}
  end
end
