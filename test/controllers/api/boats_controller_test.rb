require 'test_helper'

class Api::BoatsControllerTest < ActionDispatch::IntegrationTest

  include APIBoatController

  def setup
    @user = users(:corey)
    @boat = {
      name: 'Sexy Hog',
      length: 40,
      location: 'The Woods'
    }
  end

  test 'Valid submission returns :accepted 202 ' do
    create_boat(@user, @boat)
    assert_response :success
  end

  test 'Valid submission creates Boat' do
    assert_difference 'Boat.count' do
      create_boat(@user, @boat)
    end
  end

  test 'Boat is rendered in Json after submission' do
    create_boat(@user, @boat)
    response = json_parse(@response.body)
    assert_equal @boat[:name], response['name']
    assert_equal @boat[:location], response['location']
    assert_equal @boat[:length], response['length']
  end

  test 'Improper authentication fails to create boat, 422 :unprocessable_entity' do
    assert_no_difference 'Boat.count' do
      create_faulty_boat(@user, @boat)
    end
    assert_response 422, 'Boat was created without valid token authentication'
  end

  test 'Bad data returns 422 :unprocessable_entity' do
    create_boat(@user, {
      name: ''
    })
    assert_response 422, 'Faulty Data Slipped Through'
  end

end
