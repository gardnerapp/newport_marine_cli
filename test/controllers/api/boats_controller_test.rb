require 'test_helper'

class Api::BoatsControllerTest < ActionDispatch::IntegrationTest


  def setup
    # @user
    @boat = {
      name: "Sexy Hog",
      length: 40,
      location: "The Woods"
    }
  end

  test 'Valid submission returns :accepted/202 ' do

  end

  test 'Valid submission creates Boat which belongs to user' do

  end

  test 'Boat rendered in Json' do

  end

  test 'Improper authentication fails to create boat, 422 \:unprocessable_entity' do

  end

  test 'Bad data returns 422 \:unprocessable_entity' do

  end


end
