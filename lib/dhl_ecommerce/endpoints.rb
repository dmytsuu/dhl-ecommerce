# frozen_string_literal: true

module DhlEcommerce
  class Client
    module Endpoints
      def create_label(options = {})
        params = {
          labelRequest: {
            hdr: {
              messageType: 'LABEL',
              messageDateTime: DateTime.now.to_s,
              accessToken: @access_token,
              messageVersion: '1.4',
              messageLanguage: 'en'
            },
            bd: options
          }
        }
        post('/rest/v2/Label', params)
      end

      def track(options = {})
        params = {
          trackItemRequest: {
            hdr: {
              messageType: 'TRACKITEM',
              messageDateTime: DateTime.now.to_s,
              accessToken: @access_token,
              messageVersion: '1.0',
              messageLanguage: 'en'
            },
            bd: options
          }
        }
        post('/rest/v3/Tracking/', params)
      end

      def destroy_shipment(options = {})
        params = {
          deleteShipmentReq: {
            hdr: {
              messageType: 'DELETESHIPMENT',
              messageDateTime: DateTime.now.to_s,
              accessToken: @access_token,
              messageVersion: '1.0',
              messageLanguage: 'en'
            },
            bd: options
          }
        }
        post('/rest/v2/Label/Delete', params)
      end
    end
  end
end
