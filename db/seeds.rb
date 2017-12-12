Pledge.destroy_all
Reward.destroy_all
User.destroy_all
Project.destroy_all
Category.destroy_all
Update.destroy_all


Category.create!(name:"Technology", description: "Tech projects")
Category.create!(name:"Finance", description: "Finance projects")
Category.create!(name:"Health", description: "Health projects")
Category.create!(name:"Food", description: "Food projects")
Category.create!(name:"Art", description: "Art projects")


5.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    password: 'password',
    password_confirmation: 'password'
  )
end

10.times do
  project = Project.create!(
              title: Faker::App.name,
              description: Faker::Lorem.paragraph,
              goal: rand(100000),
              start_date: Time.now.utc - rand(60).days,
              end_date: Time.now.utc + rand(10).days,
              category: Category.all.sample,
              user: User.all.sample,
              image: "https://picsum.photos/1280/720/?random"
            )

  5.times do
    project.rewards.create!(
      description: Faker::Superhero.power,
      dollar_amount: rand(100),
    )
  end
end


20.times do
  project = Project.all.sample

  Pledge.create!(
    user: User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.free_email,
      password: 'password',
      password_confirmation: 'password'
    ),
    project: project,
    dollar_amount: project.rewards.sample.dollar_amount + rand(10)
  )
end

20.times do
  project = Project.all.sample
    Update.create!(
    title: Faker::App.name,
    content: Faker::Lorem.paragraph,
    project: project,
    user: project.user
  )
end
