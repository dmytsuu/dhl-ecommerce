# frozen_string_literal: true

module DhlEcommerce
  class Client
    module Connection
      def get(path, options = {})
        request :get, path, options
      end

      def post(path, options = {})
        request :post, path, options
      end

      private

      def request(http_method, path, options)
        response = self.class.send(http_method, path, body: options.to_json)
        response.parsed_response
      end
    end
  end
end
