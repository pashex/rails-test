# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    sequence(:name) { |n| "book_#{n}_name" }
    sequence(:description) { |n| "book_#{n}_description" }
    sequence(:release_date) { |n| (Time.now - n.months).to_date }
  end
end
