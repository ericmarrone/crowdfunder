class Reward < ActiveRecord::Base
  belongs_to :project
  validates :description, :dollar_amount, presence: true
  # validates :dollar_amount, numericality: { :greater_than_or_equal_to => 1, message: " must be a number greater than zero." }
end
