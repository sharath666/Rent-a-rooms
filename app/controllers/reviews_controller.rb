class ReviewsController < ApplicationController
	before_action :authenticate_user!
	def create
		@review = Review.new(review_params)
		@review.user_id = current_user.id
		
		if  @review.save
			redirect_to rooms_path, notice: "Review is successfully added"
	
		end
	end

# 	def add_review
# @all_booking = Booking.where('user_id=?', self.user_id)

# @all_booking.each do |booking|
# if booking.end_date > Date.today
# redirect_to rooms_path(booking.room_id)
# else
# redirect_to rooms_path	

# end
# end
# end


def destroy 
@review = Review.find(params[:id])
@review.destroy
redirect_to room_path(@room.id)

end

private
	 def review_params
	 	params[:review].permit(:review, :food_rating, :cleanliness_rating, :safety_rating, :locality_rating, :room_id, :user_id, :facility_rating)
end
end
		