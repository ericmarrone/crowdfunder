class User < ActiveRecord::Base
  has_secure_password
  has_many :projects
  has_many :pledges
  has_many  :updates

  validates :password, length: { minimum: 8 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def projects_backed
    projects_backed = []
    self.pledges.each do |pledge|
      if !projects.include?(pledge.project)
        projects_backed << pledge.project
      end
    end
    projects_backed
  end
end
