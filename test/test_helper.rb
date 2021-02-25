ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  module APIUserController
    def json_parse(response_body)
      JSON.parse response_body
    end
    
    # post request to API
    def create_user(user)
      post api_users_path, params: {
        user: user
      }
    end
  end

  module APISessions
    include APIUserController
    def login_user(user, password)
      post api_login_path, params: { session: {
        phone: user.phone,
        password: password
      }}
    end

  end



end
