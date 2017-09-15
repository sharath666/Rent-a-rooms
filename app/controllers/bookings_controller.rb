class BookingsController < ApplicationController
	load_and_authorize_resource
before_action :set_booking, only: [:show, :edit, :update, :destroy]
def index
	@booking= Booking.all
end
def create
	@booking= Booking.new(booking_params)
	@booking.user_id = current_user.id
	if @booking.save
		 Notification.booking_confirmation(@booking).deliver!
		 Notification.rooms_confirmation(@booking).deliver!
		redirect_to bookings_path

	else
		redirect_to room_path(@booking.room_id), notice: "#{@booking.errors[:base]}"
	end
end


def show

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
	
		@booking= Booking.where('is_confirmed = ?', false)
end

private
def booking_params
params[:booking].permit(:start_date, :end_date, :user_id, :room_id, :is_confirmed)
end
def set_booking
	@booking = Booking.find(params[:id])
end
end