#remove validation for project start date before running db:reset
Pledge.destroy_all
Reward.destroy_all
User.destroy_all
Project.destroy_all
Category.destroy_all
Update.destroy_all
Comment.destroy_all


Category.create!(name:"Technology", description: "Tech projects", image:"https://images.theconversation.com/files/195515/original/file-20171120-18561-18u1oqs.jpg?ixlib=rb-1.1.0&rect=976%2C437%2C2553%2C2553&q=45&auto=format&w=668&h=668&fit=crop")
Category.create!(name:"Finance", description: "Finance projects", image: "https://www.synchronybank.com/sites/syfbank/images/ico-savings.png")
Category.create!(name:"Health", description: "Health projects", image: "https://lh3.googleusercontent.com/mxYA2XnI-4eqO2FaqLDoGird7yERflxs4zmthWhIHVKfzbQJZr-ILx_Ea-Fu1vha5A=w300")
Category.create!(name:"Food", description: "Food projects", image: "http://nutritionstudies.org/wp-content/uploads/2017/03/plant-food-fruits.jpg")
Category.create!(name:"Art", description: "Art projects", image:"https://i.pinimg.com/736x/30/9d/7d/309d7db3ec643cc4a22619b9316690bf--peanuts-cartoon-peanuts-gang.jpg")


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


Project.all.each do |project|
  2.times do
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

20.times do
  project = Project.all.sample
  user = project.users.all.sample
  Comment.create!(
  title: Faker::App.name,
  comment: Faker::Lorem.paragraph,
  project: project,
  user: user
  )
end
