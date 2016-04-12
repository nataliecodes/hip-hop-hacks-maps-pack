class Location < ActiveRecord::Base
	validates :name, :canonical_name, :target_type, presence: true

end