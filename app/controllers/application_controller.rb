require 'net/http'
require 'uri'
require 'json'
class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :logged_in?

  private

  def logged_in?
    if session[:user_id].blank?
      redirect_to login_path
    end
  end

end