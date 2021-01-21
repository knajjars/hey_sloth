user = User.new email: 'k@k.com', password: 'password', password_confirmation: 'password'
user.skip_confirmation!
user.save!

p "Created test user!"