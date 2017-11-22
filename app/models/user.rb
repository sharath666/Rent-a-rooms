class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]
         validates_presence_of :username
         validates_uniqueness_of :username
         validates_presence_of :first_name, :last_name, :mobile
         belongs_to :role
         has_many :rooms
         has_many :bookings
         before_create :assign_def_role


		def role?(role)
          self.role.name.include?(role)
    end
         def assign_def_role
         	self.role_id = Role.last.id
         end
     
end
