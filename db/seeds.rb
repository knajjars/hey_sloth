user = User.new email: 'k@k.com', password: 'password', password_confirmation: 'password'
user.skip_confirmation!
user.save!

puts 'Created test user!'

sl1 = FireLink.create user: user, url: 'awesome1', note: 'My Awesome Note!'
sl1.logo.attach(io: File.open('spec/fixtures/image.png'),
                filename: 'image.png')
sl1.save!

puts 'Created Fire Links!'

Testimonial.create! name: 'Homer Simpson', company: 'Springfield Nuclear Plant', role: 'Engineer',
                    social_link: 'https://www.twitter.com/homer', user: user, content: 'This thing is good! Right Bart...', showcase: true, fire_link: sl1

Testimonial.create! name: 'Josef Burton',
                    company: 'Asd',
                    role: 'Engineer',
                    content: 'What an amazing tool! Easy setup and start collecting immediately. I love the UI as well ❤️',
                    showcase: true,
                    source: 1,
                    social_link: 'https://twitter.com/knajjars/status/1345818236923863041',
                    tweet_status_id: '1345818236923863041',
                    tweet_url: 'https://twitter.com/knajjars/status/1345818236923863041',
                    tweet_image_url: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                    tweet_date: 'Fri, 26 Feb 2021',
                    tweet_user_id: '123',
                    tweet_retweet_count: '1',
                    tweet_favorite_count: '1',
                    user: user

Testimonial.create! name: 'Victoria Moore',
                    company: 'Asd',
                    role: 'Engineer',
                    content: 'All I can say about this product is: I love it.',
                    showcase: true,
                    source: 1,
                    social_link: 'https://twitter.com/knajjars/status/1345818236923863041',
                    tweet_status_id: '1345818236923863041',
                    tweet_url: 'https://twitter.com/knajjars/status/1345818236923863041',
                    tweet_image_url: 'https://images.pexels.com/photos/4993047/pexels-photo-4993047.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                    tweet_date: 'Sat, 22 Jan 2021',
                    tweet_user_id: '123',
                    tweet_retweet_count: '1',
                    tweet_favorite_count: '1',
                    user: user

carlos_testimonial = Testimonial.create name: 'Carlos Espinoza', social_link: 'https://www.twitter.com/bart', user: user,
                                        content: 'An excellent solution, which helps me stay focus on my business.', fire_link: sl1
carlos_testimonial.image.attach(io: File.open('spec/fixtures/carlos.png'),
                                filename: 'carlos.png')
carlos_testimonial.save!

Testimonial.create! name: 'Fernanda Cunha',
                    company: 'Asd',
                    role: 'Engineer',
                    content: 'Amazing no-code tool.',
                    showcase: true,
                    source: 1,
                    social_link: 'https://twitter.com/knajjars/status/1345818236923863041',
                    tweet_status_id: '1345818236923863041',
                    tweet_url: 'https://twitter.com/knajjars/status/1345818236923863041',
                    tweet_image_url: 'https://images.pexels.com/photos/3916455/pexels-photo-3916455.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                    tweet_date: 'Sat, 22 Jan 2021',
                    tweet_user_id: '123',
                    tweet_retweet_count: '1',
                    tweet_favorite_count: '1',
                    user: user

camille_testimonial = Testimonial.create name: 'Camille Villeneuve', social_link: 'https://www.twitter.com/camille', user: user,
                                         content: 'I don\'t know a thing about coding and yet the setup was super easy!', fire_link: sl1
camille_testimonial.image.attach(io: File.open('spec/fixtures/camille.png'),
                                 filename: 'camille.png')
camille_testimonial.save!

Testimonial.create! name: 'Alec Mahl',
                    company: 'Asd',
                    role: 'Engineer',
                    content: 'My team suggested using this product rather than building the feature itself. Smart decision.',
                    showcase: true,
                    source: 1,
                    social_link: 'https://twitter.com/knajjars/status/1345818236923863041',
                    tweet_status_id: '1345818236923863041',
                    tweet_url: 'https://twitter.com/knajjars/status/1345818236923863041',
                    tweet_image_url: 'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                    tweet_date: 'Sat, 22 Jan 2021',
                    tweet_user_id: '123',
                    tweet_retweet_count: '1',
                    tweet_favorite_count: '1',
                    user: user

Testimonial.create! name: 'Norma Smith',
                    company: 'Asd',
                    role: 'Engineer',
                    content: 'We used to store our users feedback in spreadsheets. What an improvement!',
                    showcase: true,
                    source: 1,
                    social_link: 'https://twitter.com/knajjars/status/1345818236923863041',
                    tweet_status_id: '1345818236923863041',
                    tweet_url: 'https://twitter.com/knajjars/status/1345818236923863041',
                    tweet_image_url: 'https://images.pexels.com/photos/3061415/pexels-photo-3061415.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                    tweet_date: 'Sat, 22 Jan 2021',
                    tweet_user_id: '123',
                    tweet_retweet_count: '1',
                    tweet_favorite_count: '1',
                    user: user

puts 'Created Testimonials!'
