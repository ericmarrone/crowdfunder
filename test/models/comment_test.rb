require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = build(:comment)
    @pledge = build(:pledge)
    @pledge.user = @comment.user
  end
  # end

  test 'comment can be created' do
    @comment.save
    assert @comment.valid?
    assert @comment.persisted?
  end
end
