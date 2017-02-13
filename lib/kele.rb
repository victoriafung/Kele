require 'httparty'

class Kele
  include HTTParty
  # base_uri "https://www.bloc.io/api/v1/"

  def initialize(username, password)
    response = self.class.post(base_api_endpoint("sessions"), body: { "username": username, "password": password } )
    puts response.code
    raise "invalid email/password" if response.code == 404
    @auth_token = response["auth_token"]
  end

  private
  def base_api_endpoint(session)
    "https://www.bloc.io/api/v1/#{session}"
  end
end
