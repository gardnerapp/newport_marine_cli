require 'test_helper'

class BoatTest < ActiveSupport::TestCase

  def setup
    @user = users(:corey)
    @boat = @user.boats.build(name: 'The Hog', location: 'Newport', length: 30, user_id: @user.id)
  end

  test 'should be valid' do
    assert @boat.valid?
  end

  test 'user id should be present' do
    @boat.user_id = nil
    assert_not @boat.valid?
  end

  test 'location should be present' do
    @boat.location = " "*20
    assert_not @boat.valid?
  end

  test 'location should not be too long' do
    @boat.location = "1"* 101
    assert_not @boat.valid?
  end

  test 'length should be present' do
    @boat.length = nil
    assert_not @boat.valid?
  end

end
