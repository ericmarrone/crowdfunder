FactoryBot.define do
  factory :user do
    sequence :first_name do |n|
      "person#{n}"
    end

    sequence :last_name do |n|
      "person#{n}"
    end

    sequence :email do |n|
      "person#{n}@example.com"
    end
    
    password              "12345678"
    password_confirmation "12345678"
  end
end
