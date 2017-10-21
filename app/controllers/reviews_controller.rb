class ReviewsController < ApplicationController
	before_create :
	def create
		@review = Review.new(review_params)
		@review.user_id = current_user.id

		if  @review.save
			redirect_to rooms_path, notice: "Review is successfully added"
		else
			render action: "new"
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

private
	 def review_params
	 	params[:room].permit(:review, :food_rating, :cleanliness_rating, :safety_rating, :locality_rating, :room_id, :user_id, :facilty_rating)
end
		