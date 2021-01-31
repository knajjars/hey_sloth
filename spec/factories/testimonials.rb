FactoryBot.define do
  factory :testimonial do
    name { Faker::Internet.username }
    content { Faker::Lorem.paragraph }
    source { 0 }
    association :user

    after(:build) do |testimonial|
      testimonial.user = FactoryBot.create(:user) if testimonial.user.nil?
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

    trait :with_rich_text do
      rich_text { "<div><strong>This is awesome!<br></strong><br></div><ul><li>I am a test</li><li><em>and this rocks!</em></li><li><del>truly.</del></li></ul" }
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
