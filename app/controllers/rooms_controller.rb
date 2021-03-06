class RoomsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

load_and_authorize_resource
before_action :set_room, only: [:show, :edit, :update, :destroy]

def index
	@rooms = Room.where('is_authorized=?', true)
end
def new
	@room = Room.new
end

def create

	@room = Room.new(room_params)
	@room.user_id = current_user.id
	#@room.latitude = 12.00	
	#@room.longitude = 13.00
	respond_to do |format|
		if @room.save
		format.html { redirect_to rooms_path, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @room }
		format.js
		
		else
		format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
		format.js
end
end
end

def show
@booking = Booking.new
@review = Review.new
@reviews = Review.all
end
def edit
end
def update
			if @room.update_attributes(room_params)
			redirect_to room_path(@room.id), notice: "successfully updated the room"
		else
			render action: "new"

		end
		if @room.is_authorized == true
		Notification.authorize_confirmation(@room).deliver!
		end
end
def destroy
	@room.destroy
	redirect_to rooms_path, notice: "successfully deleted the rooms"

end


def unauthorize
@rooms = Room.where('is_authorized=?', false)

end

def myrooms
	@rooms = Room.where('user_id=?',current_user.id )
end

def allbookings
	@mybookings = Room.where('user_id=?', current_user.id)

end


def check_booking
@room = Booking.where('start_date > ?',  Date.today)
end
private
def set_room
	@room = Room.find(params[:id])
end
def room_params
	params[:room].permit(:name, :description, :price, :rules, :address, :longitude, :latitude, :images, :city_id,:user_id,:is_authorized, amenity_ids:[])

end
end

