ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  module JsonHelper
    def json_parse(response_body)
      JSON.parse response_body
    end
  end

  module APIUserController
    include JsonHelper
    # post request to API
    def create_user(user)
      post api_users_path, params: {
        user: user
      }
    end
  end

  module APISessionsController
    include JsonHelper
    def login_user(user, password)
      post api_login_path, params: { user: {
        phone: user.phone,
        password: password
      }}
    end
  end

  module APIBoatController
    include JsonHelper

    def create_boat(user, boat)
      user.remember
      post api_boats_path, params: {
        id: user.id,
        token: user.remember_token,
        boat: boat
      }
    end

    def create_faulty_boat(user, boat)
      user.remember
      post api_boats_path, params: {
        id: user.id,
        token: 'Not the Actual Token',
        boat: boat
      }
    end
  end

  module APIAppointmentController
    def set_appointment(user, appointment)
      user.remember
      post api_appointments_path, params: {
        appointment: appointment,
        token: user.remember_token
      }
    end
 end

end
