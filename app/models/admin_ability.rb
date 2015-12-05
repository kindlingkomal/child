class AdminAbility
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new # guest user (not logged in)
    if user
      can :manage, :all
      cannot :update, PickUp do |pickup|
        pickup.status != "pending" || pickup.start_time.utc <= Time.now.utc
      end
    else
      cannot :read, :all
    end
  end
end