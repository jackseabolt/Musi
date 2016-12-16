class Genre < ApplicationRecord

	validates :name, :presence => true 

	has_many :genres_profiles
	has_many :profiles, :through => :genres_profiles
end
