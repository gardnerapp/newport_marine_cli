require 'test_helper'

class Api::BoatsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get api_boats_new_url
    assert_response :success
  end

end
