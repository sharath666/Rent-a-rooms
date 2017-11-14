class DashboardController < ApplicationController
	before_action :authenticate_user!

  def index
  	@bookings = current_user.bookings
  	
  end
  def user
  	@users = User.all.where('role_id!=?', 1)
  end
end
