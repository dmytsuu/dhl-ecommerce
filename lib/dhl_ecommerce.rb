require 'dhl_ecommerce/constants'
require 'dhl_ecommerce/logger'
require 'base64'
require 'httparty'

module DhlEcommerce
  class Client
    include HTTParty
    base_uri BASE_URL

    def initialize(client_id: SANDBOX_CLIENT_ID, client_secret: SANDBOX_CLIENT_SECRET)
      @encoded_credentials = Base64.strict_encode64("#{client_id}:#{client_secret}")
    end

    def authorize
      headers = { accept: 'application/json', authorization: "Basic #{@encoded_credentials}" }
      response = HTTParty.get(AUTH_URL, headers: headers)
      @access_token = JSON.parse(response.body).dig('access_token')
      return DhlEcommerce.log_info('Authorize failure: ' << response.body) unless @access_token

      assign_default_headers
    end

    private

    def assign_default_headers
      headers = { accept: 'application/json', authorization: "Bearer #{@access_token}", content_type: 'application/json' }
      self.class.default_options.merge!(headers: headers)
    end
  end
end
