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

	has_attached_file :image, styles: { normal: "500x360#", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png", default_style: :normal
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  has_attached_file :audioclip, { validate_media_type: false } 
  #validates_attachment_content_type :audioclip, content_type: ['audio/mp3','audio/mpeg']

  has_attached_file :audioclip2, { validate_media_type: false } 
  #validates_attachment_content_type :audioclip2, content_type: ['audio/mp3','audio/mpeg']

  has_attached_file :audioclip3, { validate_media_type: false } 
  #validates_attachment_content_type :audioclip3, content_type: ['audio/mp3','audio/mpeg']

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


