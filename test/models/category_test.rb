require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = build(:category)
  end

  test 'valid category can be created' do
    @category.save
    assert @category.valid?
    assert @category.persisted?
    assert @category.name
  end

  test 'category is invlaid without name' do
    @category.name = nil
    @category.save
    assert @category.invalid?, 'Category should not save without name'
  end
end
