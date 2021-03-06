FactoryBot.define do
  factory :project do
    title       "Test Project"
    description "Super fun project"
    goal        100
    start_date  (Time.now.utc + 1.days)
    end_date    (Time.now.utc + 5.days)
    image       "https://picsum.photos/200"
    user
  end
end
