class Booking < ActiveRecord::Base
	belongs_to :room
	belongs_to :user
	validates_presence_of :start_date, :end_date


	validate :check_booking, :booking, on: :create


	def check_booking
		if (self.start_date < Date.today) 
			self.errors.add(:base, "date has to be greater than today")
		elsif (self.end_date < self.start_date) || (self.end_date == self.start_date)
				self.errors.add(:base, "end_date has to be greater than start_date")

		end
	
	end
	def booking
		n1= self.start_date
		n2= self.end_date

		now_booking= (n1..n2).to_a
		
		all_booking= Booking.where("room_id=?", self.room_id)
		all_booking.each do |data|
			n3=data.start_date
			n4=data.end_date
		
			all_start_date_end_date = (n3..n4).to_a

			now_booking.each do| data|
				if all_start_date_end_date.include?(data)
				self.errors.add(:base,"already booked")
				break
			end
		end		
		end
	end


end