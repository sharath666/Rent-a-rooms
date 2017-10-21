class SpecialPrice < ActiveRecord::Base
	belongs_to :room
	belongs_to :special_price
	validates :room_id, :start_date, :end_date, :price, presence:true 
end
