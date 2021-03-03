user = User.new email: 'k@k.com', password: 'password', password_confirmation: 'password'
user.skip_confirmation!
user.save!

puts 'Created test user!'

sl1 = FireLink.create user: user, url: 'awesome1', note: 'My Awesome Note!'
sl1.logo.attach(io: File.open('spec/fixtures/image.png'),
                filename: 'image.png')
sl1.save!

puts 'Created Fire Links!'

Testimonial.create! name: 'Homer Simpson', company: 'Springfield Nuclear Plant', role: 'Engineer', social_link: 'https://www.twitter.com/homer', user: user, content: 'This thing is good! Right Bart...', showcase: true, fire_link: sl1
Testimonial.create! name: 'Margie Simpson', role: 'House wife', social_link: 'https://www.twitter.com/margie', user: user, content: 'I am not sure.', fire_link: sl1
Testimonial.create! name: 'Bart Simpson', social_link: 'https://www.twitter.com/bart', user: user, content: 'Ookaaay, I think I like it.', fire_link: sl1

puts 'Created Testimonials!'