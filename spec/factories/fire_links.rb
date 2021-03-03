FactoryBot.define do
  factory :fire_link do
    url { Faker::Internet.slug }
    note { Faker::Lorem.paragraph }
    job_required { Faker::Boolean.boolean }
    image_required { Faker::Boolean.boolean }

    after(:build) do |fire_link|
      fire_link.user = FactoryBot.build(:user)
      fire_link.logo.attach(io: File.open('spec/fixtures/image.png'),
                            filename: 'image.png')
    end

    trait :image_not_required do
      image_required { false }
    end
  end
end