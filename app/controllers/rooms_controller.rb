class RoomsController < ApplicationController
before_action :set_room, only: [:show, :edit, :update, :destroy]
def index
	@rooms = Room.all
end
def new
	@room = Room.new
end

def create

	@room = Room.new(room_params)
	@room.user_id = current_user.id
	#@room.latitude = 12.00	
	#@room.longitude = 13.00
	if @room.save
		redirect_to rooms_path
	else
		render action: "new"
	end

end
def show

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
end


def unauthorize
@rooms = Room.all

end

def myrooms
	@room = Room.find_by(params[:id])
	if @room.user_id = current_user.id
		@rooms = @room.user.rooms.all
end
end
private
def set_room
	@room = Room.find(params[:id])
end
def room_params
	params[:room].permit(:name, :description, :price, :rules, :address, :longitude, :latitude, :images, :city_id,:user_id,:is_authorized, amenity_ids:[])

end
end
