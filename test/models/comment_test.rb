require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = build(:comment)
  end


  test 'comment can be created' do
    @pledge = create(:pledge, user: @comment.user)
    @project = @pledge.project
    @comment.project = @project
    @comment.save
    assert @comment.valid?
    assert @comment.persisted?
  end

  test 'comment cannot be created if user did not back project' do
    @comment.save
    refute @comment.valid?
    refute @comment.persisted?
  end
end
