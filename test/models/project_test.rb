require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def setup
    @project = build(:project)
  end

  test 'valid project can be created' do
    @project.save
    assert @project.valid?
    assert @project.persisted?
    assert @project.user
  end

  test 'project is invalid without owner' do
    @project.user = nil
    @project.save
    assert @project.invalid?, 'Project should not save without owner.'
  end

  test "end date after start date" do
    result = @project.end_date_before_start_date?
    refute result
  end

  test "end date before start date" do
    @project.end_date = Date.today - 1.month
    result = @project.end_date_before_start_date?
    assert result
  end

  test 'project is invalid with negative goal number' do
    @project.goal = -200
    assert @project.invalid?, 'Project goal cannot be negative.'
  end

  test 'start date is in future' do
    result = @project.start_date_not_in_future?
    refute result
  end

  test 'start date is in past' do
    @project.start_date = Time.now.utc - 2.days
    result = @project.start_date_not_in_future?
    assert result
  end
end
