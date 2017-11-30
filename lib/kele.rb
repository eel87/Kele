require 'httparty'
require 'json'
require './lib/kele/roadmap.rb'

class Kele
  include HTTParty
  include Roadmap
  
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
  
  def get_mentor_availability(mentor_id)
    response = self.class.get(@base_url + "/mentors/#{mentor_id}/student_availability", headers: {"authorization" => @auth_token})
    JSON.parse(response.body)
  end
  
  def get_messages(page = nil)
    values = {
      headers: {"authorization" => @auth_token },
      body: {"page" => page}
    }
    response = self.class.get(@base_url + "/message_threads/", values)
    JSON.parse(response.body)
  end
  
  def create_message(sender_email, recipient_id, subject, message)
    values = {
      headers: {"authorization" => @auth_token},
      body: { "sender_email" => sender_email,
              "recipient_id" => recipient_id,
              "subject" => subject,
              "message" => message
      }
    }
    response = self.class.get(@base_url + "/messages", values)
    JSON.parse(response.body)
  end
end