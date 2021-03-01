require 'test_helper'

class Api::AppointmentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users :corey
    @appointment = {
      time: Time.now,
      title: 'wash',
      total: 60000.00,
      user_id: @user.id,
      services: {}.as_json,
      additional_instructions: 'walk cooper',
      token: @user.remember_token
    }
  end

  # TODO api Appointments_path helper not available
  # reset routes and manually regenerate controller

  test 'User should be Authenticated before creating appointment' do
    assert_difference 'Appointment.count' do
      post api_appointments_path, params: {
        appointment: @appointment,
        token: @user.remember_token
      }
    end
  end

  test 'Invalid Authentication during create returns correct message, status code 422/:unprocessable_entity' do

  end

  test 'Invalid Appointment params does not save appointment & renders status code 422/:unprocessable_entity' do

  end

  test 'User should be Authenticated before Indexing' do

  end

  test 'Invalid Authentication during index returns correct message, status code 422/:unprocessable_entity' do

  end

  test 'Only upcoming appointments rendered by index' do

  end

end
