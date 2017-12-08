class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner

  validates :title, :user_id, :description, :goal, :start_date, :end_date, presence: true
  validate  :end_date_is_after_start_date

  def end_date_is_after_start_date
    end_date >= start_date
  end
end
