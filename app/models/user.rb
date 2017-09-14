class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]
         belongs_to :role
         has_many :rooms
         has_many
         before_create :assign_def_role


		def role?(role)
          self.role.name== role
    end
         def assign_def_role
         	self.role_id = Role.last.id
         end
     
end
