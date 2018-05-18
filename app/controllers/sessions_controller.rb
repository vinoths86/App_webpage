class SessionsController < ApplicationController

  skip_before_action :logged_in?, only: [:login, :verify_login, :create]

  def login
    render layout: false
  end

  def verify_login
    data = {
        email: params[:email],
        password: params[:password]
    }
    response = send_request('/verify-login', data)
    reset_session
    if response['status']
      session[:email] = params[:email]
      session[:user_id] = response['user_id']
      session[:auth_token] = response['auth_token']
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

  def create
    data = {data: request.env["omniauth.auth"].to_json}
    response = send_request("/sessions", data)

    reset_session
    if response['status']
      session[:email] = params[:email]
      session[:user_id] = response['user_id']
      session[:auth_token] = response['auth_token']
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end

  private

  def send_request(url, data)
    uri = URI.parse(Webapp.config.api_url + url)

    http = Net::HTTP.new(uri.host, uri.port)
    headers = {'Content-Type' => 'application/json'}
    request = Net::HTTP::Post.new(uri.path, headers)
    request.body = data.to_json

    response = http.request(request)
    JSON.parse(response.body)
  end
end