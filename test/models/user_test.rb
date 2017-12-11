require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = build(:user)
  end

  test "email must be unique" do
    @user.save
    @user_2 = build(:user)
    refute @user_2.valid?
  end

  test "user must include password_confirmation on create" do
    @user.password_confirmation = nil
    refute @user.valid?
  end

  test "password must match confirmation" do
    @user.password = nil
    refute @user.valid?
  end

  test "password must be at least 8 characters long" do
    @user.password = "123"
    refute @user.valid?
  end
end
