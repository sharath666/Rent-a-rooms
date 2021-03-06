class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
        can [:read], [Room]

       elsif user.role? "admin"
            can :manage, :all
        elsif user.role? "host" 
            can [:index,:update, :is_confirmed], [Booking]
            can [:read, :myrooms ], [Room]
            can [:read, :allbookings], [Room]
            can [:create,:read], [Room]
          can :manage, SpecialPrice, :room => { :user_id => user.id }
            #is_confirmed is the newly created action so we are calling is_confirmed action
            can [:update, :destroy], Room do |room|
                room.user_id =user.id
                can [:destroy], [Review]
            end

            can :read, [City, Amenity]
        elsif
            user.role? "guest"
            can [:index,:create, :destroy], [Booking]
            can [:create,:read], [Room]
            can :read, [City]
            can :read, [SpecialPrice]
             

        end
    end

end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
