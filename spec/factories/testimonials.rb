FactoryBot.define do
  factory :testimonial do
    name { Faker::Internet.username }
    testimonial { Faker::Lorem.paragraph }
    source { 0 }
    association :user

    after(:build) do |testimonial|
      testimonial.user = FactoryBot.create(:user)
    end

    trait :with_shareable_link do
      after(:build) do |testimonial|
        testimonial.shareable_link = FactoryBot.create(:shareable_link, image_required: false)
      end
    end

    trait :with_shareable_link_and_image_required do
      after(:build) do |testimonial|
        testimonial.shareable_link = FactoryBot.create(:shareable_link, image_required: true)
      end
    end

    trait :tweet do
      source { 1 }
      tweet_status_id { Faker::Internet.uuid }
      tweet_url { Faker::Internet.url }
      tweet_image_url { Faker::Internet.url }
      tweet_user_id { Faker::Internet.uuid }
    end
  end

  # factory :tweet_testimonial, class: "Testimonial" do
  #   name { Faker::Internet.username }
  #   testimonial { Faker::Lorem.paragraph }
  #   source { 1 }
  #   tweet_status_id { Faker::Twitter.status }
  #   tweet_url { Faker::Internet.url }
  #   tweet_image_url { Faker::Internet.url }
  #   tweet_user_id { Faker::Twitter.user }
  # end
end
