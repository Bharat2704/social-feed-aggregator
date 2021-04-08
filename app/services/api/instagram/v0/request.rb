module Api
  module Instagram
    module V0
      class Request < Base

        def perform
          client = Client.new
          request(
            client,
            http_method: :get,
            endpoint: "/instagram"
          )
        end
      end
    end
  end
end
