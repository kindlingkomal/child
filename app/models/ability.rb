class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.user?
      can :manage, :all
      cannot :update, PickUp do |pickup|
        pickup.status != "pending"
      end
    elsif user.ragpicker?
      can :manage, :all
      cannot [:new, :create], PickUp
    else
      cannot :read, :all
      can :new, PickUp
    end
  end
end
