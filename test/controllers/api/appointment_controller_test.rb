require 'test_helper'

class Api::AppointmentControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_appointment_create_url
    assert_response :success
  end

  test "should get index" do
    get api_appointment_index_url
    assert_response :success
  end

end
