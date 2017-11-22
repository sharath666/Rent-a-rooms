class Amenity < ActiveRecord::Base
has_many :amenity_rooms
has_many :rooms, through: :amenity_rooms
validates_presence_of :name, :description
validates_uniqueness_of :name
validates_length_of :description, :minimum=>50
end
