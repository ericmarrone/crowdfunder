require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test 'valid project can be created' do
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  test 'project is invalid without owner' do
    project = new_project
    project.user = nil
    project.save
    assert project.invalid?, 'Project should not save without owner.'
  end

  def new_user
    User.new(
      first_name:            'Sally',
      last_name:             'Lowenthal',
      email:                 'sally@example.com',
      password:              'passpass',
      password_confirmation: 'passpass'
    )
  end

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today,
      end_date:    Date.today + 1.month,
      goal:        50000,
      user_id: new_user
    )
  end

  def setup
    @user = new_user
    @project = new_project
  end

  def test_end_date_after_start_date
    result = @project.end_date_before_start_date?
    refute result
  end

  def test_end_date_before_start_date
    @project.end_date = Date.today - 1.month
    result = @project.end_date_before_start_date?
    assert result
  end

  def setup
     @user = new_user
     @project = new_project
   end

  def test_end_date_is_after_start_date
    result = @project.end_date_is_after_start_date

    refute result
  end

  def test_end_date_is_before_start_date
    @project.end_date = Time.now - 1.day

    result = @project.end_date_is_after_start_date

    assert result
  end
end
