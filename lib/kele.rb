require 'httparty'
require 'json'

class Kele
  include HTTParty
  
  attr_accessor :base_url
  
  def initialize(email, password)
    options = {query: { email: email, password: password } }
    @base_url = 'https://www.bloc.io/api/v1'
    response = self.class.post(@base_url + '/sessions', options) 
    @auth_token = response['auth_token']
    if @auth_token.nil?
      puts "Sorry, you have entered invalid credentials. Please try again"
    end
  end
  
  def get_me
    response = self.class.get(@base_url + '/users/me', headers: {"authorization" => @auth_token})
    JSON.parse(response.body)
  end
  
  def get_mentor_availability
    response = self.class.get(@base_url + '/mentors/946/student_availability', headers: {"authorization" => @auth_token})
    JSON.parse(response.body)
  end
end