class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :updates
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner
  belongs_to :category

  validates :title, :user_id, :description, :goal, :start_date, :end_date, presence: true
  validates :goal, numericality: { :greater_than_or_equal_to => 1, message: " must be a number greater than zero." }
  validate :end_date_before_start_date?
  validate :start_date_not_in_future?

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
end
