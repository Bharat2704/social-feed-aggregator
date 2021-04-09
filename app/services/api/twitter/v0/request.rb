# frozen_string_literal: true

module Api
  module Twitter
    module V0
      class Request < Base
        def perform
          client = Client.new
          request(
            client,
            http_method: :get,
            endpoint: '/twitter'
          )
        end
      end
    end
  end
end
