class Review < ActiveRecord::Base

	belongs_to :user
	
	#validates :review, length: { minimum: 150 }
	validates :food_rating, :cleanliness_rating, :safety_rating, :facility_rating, :locality_rating, presence:true, numericality:true


def self.show_rating_form(room_id, user_id)
	bookings = Booking.where('room_id = ? AND user_id = ?', room_id, user_id)
	if bookings.blank?
		return false
	else
		bookings = bookings.where('end_date <= ?', Date.today)
		if bookings.blank?
			return false
		else
			return true
		end
	end
end


end
