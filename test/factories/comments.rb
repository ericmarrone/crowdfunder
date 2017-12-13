FactoryBot.define do
  factory :comment do
    title "Comment"
    project
    user
    comment "MyText"
  end
end
