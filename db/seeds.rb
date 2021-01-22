user = User.new email: 'k@k.com', password: 'password', password_confirmation: 'password'
user.skip_confirmation!
user.save!

p "Created test user!"

ShareableLink.create! user: user, tag: 'awesome1', note: "My Awesome Note!", social_link_required: true
ShareableLink.create! user: user, tag: 'awesome2', note: "My Awesome Note!", job_required: true
ShareableLink.create! user: user, tag: 'awesome3', note: "My Awesome Note!", social_link_required: true, job_required: true

p "Created Shareable Links!"
