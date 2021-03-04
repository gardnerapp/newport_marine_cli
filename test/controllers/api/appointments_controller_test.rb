# frozen_string_literal: true
require 'test_helper'

class Api::AppointmentsControllerTest < ActionDispatch::IntegrationTest
  include APIAppointmentController
  def setup
    @user = users :corey
    @appointment = {
      time: Time.now,
      title: 'wash',
      total: 60_000.00,
      user_id: @user.id,
      services: {}.as_json,
      additional_instructions: 'walk cooper',
    }
  end

  test 'User Is Authenticated before appointment, count changes in the database' do
    assert_difference 'Appointment.count' do
      set_appointment @user, @appointment
    end
  end

  test 'Invalid Authentication fails to create appointment and returns status code 422/:unprocessable_entity' do
    assert_no_difference 'Appointment.count' do
      @user.remember
      post api_appointments_path, params: {
        appointment: @appointment,
        token: "hog"
      }
    end
    assert_response 422
  end


  test 'User should be Authenticated before Indexing' do

  end

  test 'Invalid Authentication during index returns correct message, status code 422/:unprocessable_entity' do

  end


end
