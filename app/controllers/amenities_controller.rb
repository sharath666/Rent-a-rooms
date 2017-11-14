class AmenitiesController < ApplicationController
	before_action :authenticate_user!

before_action :set_amenity, only: [:show, :edit, :update, :destroy]
def index 
	@amenities = Amenity.all
end

def new
	@amenity = Amenity.new
end
def create
	@amenity = Amenity.new(amenity_params)
	if @amenity.save
	redirect_to amenities_path
	else
	render actions: "new"
end
end
def show
end
def edit
end

def update
end

def destroy
end

private
def set_amenity
	@amenity = Amenity.find(params[:id])
end
def amenity_params
params[:amenity].permit(:name, :description)
end

end
