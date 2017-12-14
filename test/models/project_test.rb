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

  test 'total dollars raised is positive' do
    @project.save
    @pledge = build(:pledge)
    @pledge.project = @project
    @pledge.dollar_amount = 1
    @pledge.save
    result = @project.total_dollars_raised
    assert_equal(1, result)
  end

  test 'total dollars raised is zero' do
    @project.save
    @pledge = build(:pledge)
    @pledge.project = @project
    @pledge.dollar_amount = 0
    @pledge.save
    result = @project.total_dollars_raised
    assert_equal(0, result)
  end

  test 'project is finished if past end date' do
    @project.save
    @project.start_date = Time.now.utc - 10.days
    @project.end_date = Time.now.utc - 1.days
    @project.save
    @pledge = build(:pledge)
    @pledge.dollar_amount = 100
    @pledge.project = @project
    @pledge.save
    actual = Project.all_successful_projects
    expected = [@project]
    assert_equal(expected, actual)
  end

  test 'project is not finished if before end date' do
    @project.save
    @project.save
    @pledge = build(:pledge)
    @pledge.dollar_amount = 100
    @pledge.project = @project
    @pledge.save
    actual = Project.all_successful_projects
    expected = []
    assert_equal(expected, actual)

  end

  test 'project is successful if above goal level' do
    @project.save
    @project.start_date = Time.now.utc - 10.days
    @project.end_date = Time.now.utc - 1.days
    @project.save
    @pledge = build(:pledge)
    @pledge.dollar_amount = 105
    @pledge.project = @project
    @pledge.save
    result = @project.total_dollars_raised > @project.goal
    assert result


  end

  test 'project is successful if at goal level' do
    @project.save
    @project.start_date = Time.now.utc - 10.days
    @project.end_date = Time.now.utc - 1.days
    @project.save
    @pledge = build(:pledge)
    @pledge.dollar_amount = 100
    @pledge.project = @project
    @pledge.save
    result = @project.total_dollars_raised == @project.goal
    assert result
  end

  test 'project is unsuccessful if below goal level' do
    @project.save
    @project.start_date = Time.now.utc - 10.days
    @project.end_date = Time.now.utc - 1.days
    @project.save
    @pledge = build(:pledge)
    @pledge.dollar_amount = 95
    @pledge.project = @project
    @pledge.save
    result = @project.total_dollars_raised < @project.goal
    assert result

  end

  test 'all successful projects included in successfull projects array' do
    @project1 = build(:project)
    @project1.start_date = Time.now.utc - 10.days
    @project1.end_date = Time.now.utc - 1.days
    @project1.save
    @pledge1 = build(:pledge)
    @pledge1.dollar_amount = 105
    @pledge1.project = @project1
    @pledge1.save
    @project2 = build(:project)
    @project2.start_date = Time.now.utc - 10.days
    @project2.end_date = Time.now.utc - 1.days
    @project2.save
    @pledge2 = build(:pledge)
    @pledge2.dollar_amount = 95
    @pledge2.project = @project1
    @pledge2.save
    actual = Project.all_successful_projects
    expected = [@project1, @project2]
    refute_equal(expected,actual)
  end

  test 'total donations for successful projects' do
    @project1 = create(:project)
    @project1.start_date = Time.now.utc - 10.days
    @project1.end_date = Time.now.utc - 1.days
    @project1.save
    @pledge1 = build(:pledge)
    @pledge1.dollar_amount = 105
    @pledge1.project = @project1
    @pledge1.save
    @project2 = create(:project)
    @project2.start_date = Time.now.utc - 10.days
    @project2.end_date = Time.now.utc - 1.days
    @project2.save
    @pledge2 = build(:pledge)
    @pledge2.dollar_amount = 100
    @pledge2.project = @project2
    @pledge2.save
    actual = Project.total_donations_to_successful_projects
    assert_equal(205, actual)
  end

  test 'total donations for successful projects where one project does not meet goal' do
    @project1 = create(:project)
    @project1.start_date = Time.now.utc - 10.days
    @project1.end_date = Time.now.utc - 1.days
    @project1.save
    @pledge1 = build(:pledge)
    @pledge1.dollar_amount = 105
    @pledge1.project = @project1
    @pledge1.save
    @project2 = create(:project)
    @project2.start_date = Time.now.utc - 10.days
    @project2.end_date = Time.now.utc - 1.days
    @project2.save
    @pledge2 = build(:pledge)
    @pledge2.dollar_amount = 50
    @pledge2.project = @project2
    @pledge2.save
    actual = Project.total_donations_to_successful_projects
    assert_equal(105, actual)
  end
end
