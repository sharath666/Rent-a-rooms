class CitiesController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	before_action :set_city, only: [:show, :edit, :update, :destroy]
	def index
		@cities = City.all
		@city = City.new
	end
	def new
		@city=City.new
	end
	def create
		@city=City.new(city_params)
		respond_to do |format|
		if @city.save
			format.html { redirect_to cities_path, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @city }
			format.js
		
		else
			  format.html { render :new }
        format.json { render json: @city.errors, status: :unprocessable_entity }
			format.js
		
	end
end
end
def edit
end
def show
end
def update
	if @city.update_attributes(city_params)
	redirect_to ciy_path(@city.id), notice: "successfully updated the city"
end
end
def destroy
	@city.destroy
	redirect_to cities_path, notice: "successfully deleted the city"
end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name)
    end
end