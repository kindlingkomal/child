namespace :fix do
  desc "add admin user"
  task :add_admin_user => :environment do
    AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
    AdminUser.create!(email: 'admin@ragpickers.com', password: 'password', password_confirmation: 'password')
    AdminUser.create!(email: 'tinle1201@gmail.com', password: 'password', password_confirmation: 'password')
  end

  desc 'fix category_set in pickups'
  task :pickup_category_set => :environment do
  	PickUp.all.each do |pk|
  		pk.category_ids = pk.category_set
  		pk.save
  	end
  end

end
