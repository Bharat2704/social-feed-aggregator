module Api
  module Facebook
    module V0
      class Request < Base

        def perform
          client = Client.new
          request(
            client,
            http_method: :get,
            endpoint: "/facebook"
          )
        end
      end
    end
  end
end
