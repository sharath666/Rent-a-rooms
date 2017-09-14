class CitiesController < ApplicationController
	load_and_authorize_resource

	before_action :set_city, only: [:show, :edit, :update, :destroy]
	def index
		@cities = City.all
	end
	def new
		@city=City.new
	end
	def create
		@city=City.new(city_params)
		if @city.save
			redirect_to cities_path
		else
			render action: "new"
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