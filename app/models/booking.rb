class Booking < ActiveRecord::Base
	belongs_to :room
	belongs_to :user
	has_many :prices
	has_many :reviews
	validates_presence_of :start_date, :end_date


	#validate :check_booking
	validate :booking, on: :create

validate :check_offer, on: :create


	def check_booking
		#binding.pry
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
		all_booking.each do |dataty|
			n3=dataty.start_date
			n4=dataty.end_date
		
			all_start_date_end_date = (n3..n4).to_a

			now_booking.each do| data|
				if all_start_date_end_date.include?(data)
				self.errors.add(:base,"already booked")
				break
			end
		end		
		end
	end



	def check_offer
		total_price = 0
		n1= self.start_date
		n2= self.end_date
		count =0;
		#empty array to total the price

		now_booking = (n1..n2).to_a
		no_of_days = now_booking.length

	
		check_offer_on_booking =  SpecialPrice.where("room_id=?", self.room_id)
	
		check_offer_on_booking.each do |checkdate|
			num1 = checkdate.start_date
			num2 = checkdate.end_date
			all_start_date_end_date = (num1..num2).to_a
		#special_booking=now_booking - all_start_date_end_date
		now_booking.each do |booking_date|
			if all_start_date_end_date.include?(booking_date)
				total_price += checkdate.price
				count +=1;
				end
			end
				
			
			end
			non_offer_days = no_of_days - count
		
					total_price +=self.room.price * (non_offer_days)

	
		self.price = total_price
		binding.pry
		end
end