class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates  :user_id, :project_id, :title, :comment, presence: true


  def user_backed_project?
    if project.users.exclude?(self.user)
      errors.add(:user, "has not backed project")
    end
  end
end
