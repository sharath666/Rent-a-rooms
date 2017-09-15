class Changecolumnbooking < ActiveRecord::Migration
  def change
  	rename_column :bookings, :is_authorized, :is_confirmed
  end
end
