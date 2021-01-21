user = User.new email: 'k@k.com', password: 'password', password_confirmation: 'password'
user.skip_confirmation!
user.save!

p "Created test user!"

HeyBox.create! user: user, tag: 'awesome1', note: "My Awesome Note!", allowed_sources: 0
HeyBox.create! user: user, tag: 'awesome2', note: "My Awesome Note!", allowed_sources: 1
HeyBox.create! user: user, tag: 'awesome3', note: "My Awesome Note!", allowed_sources: 2

p "Created HeyBoxes!"
