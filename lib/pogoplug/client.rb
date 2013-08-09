require 'httparty'
require 'json'

module PogoPlug
  class Client
    include HTTParty
    debug_output $stdout
    base_uri 'https://service.pogoplug.com/svc/api/json'
    format :json

    # Retrieve the current version information of the service
    def version
      response = self.class.get('/getVersion')
      json = JSON.parse(response.body)
      ApiVersion.new(json['version'], json['builddate'])
    end

    # Retrieve an auth token that can be used to make additional calls
    # * *Raises* :
    #   - +AuthenticationError+ -> if PogoPlug does not like the credentials you provided
    def login(email, password)
      response = self.class.get('/loginUser', query: { email: email, password: password })
      raise_errors(response)
      response.parsed_response["valtoken"]
    end

    # Retrieve a list of devices that are registered with the PogoPlug account
    def devices(token)
      response = self.class.get('/listDevices', query: { valtoken: token })
      response.parsed_response['devices']
    end

    private

    def raise_errors(response)
      if response.parsed_response['HB-EXCEPTION'] && response.parsed_response['HB-EXCEPTION']['ecode'] == 606
        raise AuthenticationError
      end
    end
  end
end
