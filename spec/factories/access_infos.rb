# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :access_info do
    ip "MyString"
    browser "MyString"
    platform "MyString"
  end
end
