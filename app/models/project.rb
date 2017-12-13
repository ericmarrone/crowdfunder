class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :updates
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner
  belongs_to :category
  has_many :comments

  validates :title, :user_id, :description, :goal, :start_date, :end_date, presence: true
  validates :goal, numericality: { :greater_than_or_equal_to => 1, message: " must be a number greater than zero." }
  validate :end_date_before_start_date?
  validate :start_date_not_in_future?, on: :create

  def end_date_before_start_date?
    if end_date <= start_date
      errors.add(:end_date, "must be after start date")
    end
  end

   def start_date_not_in_future?
    if start_date <= Time.now.utc
      errors.add(:start_date, "must be in future")
    end
   end

  def total_dollars_raised
    pledges.sum(:dollar_amount)
  end

  def self.all_successful_projects
    finished_projects = where("end_date < ?", Time.now)
    finished_projects.reduce([]) do |successful_projects, finished_project|
      if finished_project.goal <= finished_project.total_dollars_raised
        successful_projects << finished_project
      end
    end
  end

  def self.total_donations_to_successful_projects
    all_successful_projects.reduce(0) do |total_dollars, successful_project|
      total_dollars += successful_project.pledges.sum(:dollar_amount)
    end
  end
end
