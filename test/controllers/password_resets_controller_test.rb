require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  test 'should get success' do
    get success_path
    assert_response :success
  end

end
