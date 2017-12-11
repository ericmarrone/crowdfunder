FactoryBot.define do
  factory :user do
    first_name            "Eric"
    last_name             "Marrone"
    email                 "eric@gmail.com"
    password              "12345678"
    password_confirmation "12345678"
  end
end
