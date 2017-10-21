class SpecialPricesController < ApplicationController
load_and_authorize_resource :room
  load_and_authorize_resource :special_price, :through => :room

	def new
	
		@special_price = SpecialPrice.new
	

	end

	


	def create

		@special_price = SpecialPrice.new(special_price_params)
		@special_price.room_id = params[:room_id]

		if  @special_price.save
			redirect_to rooms_path, notice: "special price is added"
		else
			render action: "new"
		end
	end


	


private

def special_price_params
	params[:special_price].permit(:room_id, :start_date, :end_date, :price)
end


end
