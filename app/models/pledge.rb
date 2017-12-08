class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate :owner_not_project_owner?


  def owner_not_project_owner?
    if self.user == project.user
      errors.add(:user, "can't be the project owner")
    end
  end
end
