namespace :fix do
  desc "add admin user"
  task :add_admin_user => :environment do
    AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
    AdminUser.create!(email: 'admin@ragpickers.com', password: 'password', password_confirmation: 'password')
    AdminUser.create!(email: 'tinle1201@gmail.com', password: 'password', password_confirmation: 'password')
  end

end
