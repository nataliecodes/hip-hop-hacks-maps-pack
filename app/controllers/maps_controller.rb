class MapsController < ApplicationController
  GEOCODE_URI = "https://maps.googleapis.com/maps/api/geocode/json"

	def index
		
	end

  def geocode_search
    if request.xhr?
      response = HTTParty.get(GEOCODE_URI, {query: {address: params[:query], key: ENV["GOOGLE_MAPS_API_KEY"]}})
      marker_positions = get_array_of_positions_from_response response
      render json: {
        marker_positions: marker_positions
      }
    end
  end

  private

  def get_array_of_positions_from_response response
    response["results"].map do |result|
      result["geometry"]["location"]
    end
  end
end
