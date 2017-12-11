require_relative '../test_helper'

class PledgeTest < ActiveSupport::TestCase

  def setup
    @pledge = build(:pledge)
  end

  test 'A pledge can be created' do
    @pledge.save
    assert @pledge.valid?
    assert @pledge.persisted?
  end

  test 'owner cannot back own project' do
    skip
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    pledge = Pledge.new(dollar_amount: 3.00, project: project)
    pledge.user = owner
    pledge.save
    assert pledge.invalid?, 'Owner should not be able to pledge towards own project'
  end

end
