require 'httparty'
require 'json'

class Kele
  include HTTParty
  
  attr_accessor :base_url
  def initialize(email, password)
    options = { body: { email: email, password: password } }
    @base_url = 'https://www.bloc.io/api/v1'
    response = self.class.post(@base_url + '/sessions', options)
    @auth_token = response["auth_token"]
    if @auth_token.nil?
      puts "Sorry, you have entered invalid credentials. Please try again"
    end
  end
end