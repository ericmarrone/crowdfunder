FactoryBot.define do
  factory :pledge do
    dollar_amount 15.0
    project
    user
  end
end
