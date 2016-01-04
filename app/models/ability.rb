class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.user?
      can :manage, :all
    elsif user.ragpicker?
      can :manage, :all
      cannot [:new, :create, :manage, :reschedule, :book, :cancel], PickUp
    else
      cannot :read, :all
      can [:new, :summary], PickUp
    end
  end
end
