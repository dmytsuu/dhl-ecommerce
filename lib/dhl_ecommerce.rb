# frozen_string_literal: true

require 'dhl_ecommerce/constants'
require 'dhl_ecommerce/connection'
require 'dhl_ecommerce/endpoints'
require 'httparty'

module DhlEcommerce
  class Client
    include HTTParty
    include DhlEcommerce::Client::Connection
    include DhlEcommerce::Client::Endpoints

    def initialize(client_id: '', password: '', production_env: false)
      self.class.base_uri (production_env ? PRODUCTION_BASE_URL : SANDBOX_BASE_URL)
      @client_id = client_id
      @password = password
      authenticate!
      self.class.default_options.merge!(headers: { 'content-type': 'application/json' })
    end

    private

    def authenticate!
      resp = HTTParty.get("#{self.class.base_uri}/rest/v1/OAuth/AccessToken", query: { clientId: @client_id, password: @password })
      @access_token = resp.dig('accessTokenResponse', 'token')
    end
  end
end
