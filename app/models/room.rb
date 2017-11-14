class Room < ActiveRecord::Base
	mount_uploader :images, ImagesUploader
	validates_presence_of :name, :description, :price, :rules,:address, :city_id
	 validates :description, length: { minimum: 150 }
	 validates :name , uniqueness:true


	has_many :amenity_rooms
	has_many :amenities, through: :amenity_rooms
	has_many :bookings
	has_many :special_prices
	has_many :reviews

	belongs_to :city
	belongs_to :user

 before_save :search_lang_and_lat
after_create :change_role



def search_lang_and_lat
	response = HTTParty.get("http://maps.googleapis.com/maps/api/geocode/json?address=#{self.address}")
		@res= JSON.parse(response.body)
		self.latitude = @res["results"][0]["geometry"]["location"]["lat"]
		self.longitude = @res["results"][0]["geometry"]["location"]["lng"]
end

def change_role

	if self.user.role.name == "guest"
	self.user.update_attributes(role_id:Role.second.id)
end
end
end