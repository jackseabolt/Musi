class Profile < ApplicationRecord

	belongs_to :user

	validates :name, :presence => true
	validates :age, :presence => true
	validates :primary_instrument, :presence => true
	validates :city, :presence => true 
	validates :status, :presence => true
	validates :years_spent_playing, :presence => true 
	validates :looking_for, :presence => true 
	validates :state, :presence => true 
	validates :image, :presence => true 

	has_attached_file :image, styles: { large: "500x500", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/


  	has_many :genres_profiles
	has_many :genres, :through => :genres_profiles

  	def instrument_image 
  		"#{self.primary_instrument}.png"
  	end 

  	def second_instrument_image 
  		"#{self.second_instrument}.png"
  	end 

  	def third_instrument_image 
  		"#{self.third_instrument}.png"
  	end 

  
end


