FactoryGirl.define do
  factory :user do
    email  Faker::Internet.email
    name   Faker::Name.name
  end

  factory :article do
    user
    title        Faker::Lorem.sentence
    content      Faker::Lorem.paragraph(50)
    published_at Time.now
  end
end
