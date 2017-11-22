class BookingsController < ApplicationController
	before_action :authenticate_user!

	load_and_authorize_resource
before_action :set_booking, only: [:update, :destroy]
def index
	@booking= Booking.all
end
def create
	@booking= Booking.new(booking_params)
	binding.pry
	@booking.user_id = current_user.id
	if @booking.save
		Notification.booking_confirmation(@booking).deliver!
		 #Notification.rooms_confirmation(@booking).deliver!
		redirect_to bookings_path

	else
		redirect_to room_path(@booking.room_id), notice: "#{@booking.errors[:base]}"
	end
end



def edit
end
def update
	if @booking.update_attributes(booking_params)
		redirect_to bookings_path
end
end
def destroy
end


def is_confirmed
		if current_user.role?("host")
		@booking= Booking.where('is_confirmed = ?', false)
	end
end

private
def booking_params
params[:booking].permit(:start_date, :end_date, :user_id, :room_id, :is_confirmed)
end
def set_booking
	@booking = Booking.find(params[:id])
end
end