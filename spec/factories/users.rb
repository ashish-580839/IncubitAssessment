FactoryBot.define do
  factory :user do
    name { "John" }

    sequence(:email) { |n| "person#{n}@example.com" }

    password { "john#123" }

    password_confirmation { "john#123" }
  end
end
