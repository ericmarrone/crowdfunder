class User < ActiveRecord::Base
  has_secure_password
  has_many :projects
  has_many :pledges
  has_many :updates
  has_many :comments

  validates :password, length: { minimum: 8 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def projects_backed
    pledges.map(&:project).uniq
  end
end
