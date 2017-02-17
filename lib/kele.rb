require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri "https://www.bloc.io/api/v1"

  def initialize(username, password)
    response = self.class.post('/sessions', body: { "username": username, "password": password } )
    puts response.code
    raise "invalid email/password" if response.code == 404
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token } )
    JSON.parse(response.body)
  end

  # private
  # def base_api_endpoint(session)
  #   "https://www.bloc.io/api/v1/#{session}"
  # end
end
