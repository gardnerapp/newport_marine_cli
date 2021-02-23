require 'test_helper'

class Api::BoatsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user
    @boat = {
      name: "Sexy Hog",
      length: 40,
      location: "The Woods"
    }
  end

  test 'Valid submission returns proper status code ' do
    post api_boats_path, params: {
      id: 1, # Do I Need to User a Fixture here
      # Or should I do a user from existing
      # initialzied in setup ??
      boat: @boat
    }
    assert_response :accepted
  end

  test 'Valid submission creates Boat and belongs to proper user' do
    assert_difference 'Boat.count' do
      post api_boats_path, params: {
        id: 1, # Do I Need to User a Fixture here
        # Or should I do a user from existing
        # initialzied in setup ??
        boat: @boat
      }
    end
    assert Boat.last.user_id == 1
    #TODO assert boat belongs to correct user in here as well
  end

  test 'Valid userID, INvalid Boat fails' do

  end

  test 'invalid UserID, valid boat fails' do

  end

end
