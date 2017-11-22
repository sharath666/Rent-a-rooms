class AmenitiesController < ApplicationController
	before_action :authenticate_user!

before_action :set_amenity, only: [:show, :edit, :update, :destroy]
def index 
	@amenities = Amenity.all
	@amenity = Amenity.new
end

def new
	@amenity = Amenity.new
end
def create
	@amenity = Amenity.new(amenity_params)
		respond_to do |format|
		if @amenity.save
			format.html { redirect_to cities_path, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @amenity }
			format.js
		
		else
			  format.html { render :new }
        format.json { render json: @amenity.errors, status: :unprocessable_entity }
			format.js
		end
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
