class ApplicationController < ActionController::Base
  include UsersHelper

  def home
    render 'layouts/home'
  end
end
