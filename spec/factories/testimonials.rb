FactoryBot.define do
  factory :testimonial do
    name { Faker::Internet.username }
    content { Faker::Lorem.paragraph }
    source { 0 }
    association :user
    social_link { Faker::Internet.url }

    after(:build) do |testimonial|
      testimonial.user = FactoryBot.create(:user) if testimonial.user.nil?
    end

    trait :with_fire_link do
      after(:build) do |testimonial|
        testimonial.fire_link = FactoryBot.create(:fire_link, image_required: false)
      end
    end

    trait :with_fire_link_and_image_required do
      after(:build) do |testimonial|
        testimonial.fire_link = FactoryBot.create(:fire_link, image_required: true)
      end
    end

    trait :with_rich_text do
      rich_text do
        '<div><strong>This is awesome!<br></strong><br></div><ul><li>I am a test</li><li><em>and this rocks!</em></li><li><del>truly.</del></li></ul'
      end
      content { nil }
    end

    trait :tweet do
      source { 1 }
      tweet_status_id { Faker::Internet.uuid }
      tweet_url { Faker::Internet.url }
      tweet_image_url { Faker::Internet.url }
      tweet_user_id { Faker::Internet.uuid }
    end
  end
end
