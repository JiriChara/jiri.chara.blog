FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name  { Faker::Name.name }
    role  { %w[admin regural moderator].sample }
  end

  factory :article do
    user
    title        { Faker::Lorem.sentence }
    content      { Faker::Lorem.paragraph(50) }
    published_at { Time.now }
    type         { %w[Article CV About].sample }
  end

  factory :comment do
    user
    article
    text { Faker::Lorem.paragraph(10) }
  end

  factory :tag do
    name { Faker::Lorem.word }
  end
end
