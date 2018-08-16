class AccessPolicy
  include AccessGranted::Policy

  def configure

    role :admin, proc { |user| user.admin? } do
      # permissions will go here
      can [:read, :create, :update, :destroy], User
      
      can [:read, :create, :update, :destroy], Trip
    end

    role :member, proc { |user| user.member? } do
      # permissions will go here
      can [:read, :create, :update, :destroy], Trip
      can :create, User
      
    end

  end
end
