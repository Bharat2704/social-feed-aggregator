module Api
  module Twitter
    module V0
      class Client
        API_ENDPOINT = 'https://takehome.io'.freeze

        def initialize(endpoint: API_ENDPOINT)
          @endpoint = endpoint
        end

        def call
          @_client ||= Faraday.new(@endpoint) do |client|
          end
        end
      end
    end
  end
end
