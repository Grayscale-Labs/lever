require 'httparty'

# TODO: Add pagination (lever limits to 100)
#     : Add configurable base URL

module Lever
  class Client
    include HTTParty
    base_uri 'https://api.sandbox.lever.co/v1'
  
    def initialize(token)
      @options = { basic_auth: { username: token } }
    end
    
    def users(id = nil)
      get_resource('/users', Lever::User, id)
    end

    def candidates(id = nil)
      get_resource('/candidates', Lever::Candidate, id)
    end

    def get_resource(base_path, objekt, id = nil)
      path = id.nil? ? base_path : "#{base_path}/#{id}"

      response = self.class.get(path, @options)
      if response.success?
        if id
          objekt.new(response.parsed_response.dig('data'))
        else
          response.parsed_response.dig('data').map do |hash|
            objekt.new(hash)
          end
        end
      end
    end
  end
end