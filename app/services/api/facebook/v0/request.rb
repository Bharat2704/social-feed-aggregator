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

        def request(client, http_method:, endpoint:, params: {})
          @response = client.call.public_send(http_method, endpoint, params)

          if response_successful?
            @data = JSON.parse(@response.body)
          else
            raise error_class, "Code: #{@response.status}, message: #{@response.body}"
          end
        end
      end
    end
  end
end
