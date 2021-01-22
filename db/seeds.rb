user = User.new email: 'k@k.com', password: 'password', password_confirmation: 'password'
user.skip_confirmation!
user.save!

puts "Created test user!"

sl1 = ShareableLink.create! user: user, tag: 'awesome1', note: "My Awesome Note!", social_link_required: true
sl2 = ShareableLink.create! user: user, tag: 'awesome2', note: "My Awesome Note!", job_required: true
sl3 = ShareableLink.create! user: user, tag: 'awesome3', note: "My Awesome Note!", social_link_required: true, job_required: true

puts "Created Shareable Links!"

Testimonial.create! name: "Homer Simpson", company: "Springfield Nuclear Plant", role: "Engineer", social_link: "https://www.twitter.com/homer", user: user, testimonial: "This thing is good! Right Bart...", showcase: true, shareable_link: sl1
Testimonial.create! name: "Margie Simpson", role: "House wife", social_link: "https://www.twitter.com/margie", user: user, testimonial: "I am not sure.", shareable_link: sl2
Testimonial.create! name: "Bart Simpson", social_link: "https://www.twitter.com/bart", user: user, testimonial: "Ookaaay, I think I like it.", shareable_link: sl3

puts "Created Testimonials!"