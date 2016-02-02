namespace :schedule do

  desc 'subscriptions recur daily'
  task :daily_subscriptions => :environment do
    Subscription.active.where(frequency: Subscription.frequencies[:daily]).find_each do |sub|
      now = Time.zone.now
      next if sub.start_time > now
      new_date = SubscriptionService.next_valid_date(sub, now)
      next unless new_date
      ActiveRecord::Base.transaction do
        sub.create_pickup if sub.update(date: new_date)
      end
    end
  end

  desc 'subscriptions recur weekly'
  task :weekly_subscriptions => :environment do
    Subscription.active.where(frequency: Subscription.frequencies[:weekly]).find_each do |sub|
      now = Time.zone.now
      next if sub.start_time > now
      new_date = SubscriptionService.next_valid_date(sub, now)
      next unless new_date
      ActiveRecord::Base.transaction do
        sub.create_pickup if sub.update(date: new_date)
      end
    end
  end

  desc 'subscriptions recur monthly'
  task :monthly_subscriptions => :environment do
    Subscription.active.where(frequency: Subscription.frequencies[:monthly]).find_each do |sub|
      now = Time.zone.now
      next if sub.start_time > now
      new_date = SubscriptionService.next_valid_date(sub, now)
      next unless new_date
      ActiveRecord::Base.transaction do
        sub.create_pickup if sub.update(date: new_date)
      end
    end
  end

end
