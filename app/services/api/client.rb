# frozen_string_literal: true

module Api
  class Client
    API_ENDPOINT = 'https://takehome.io'

    def initialize(endpoint: API_ENDPOINT)
      @endpoint = endpoint
    end

    def call
      @call ||= Faraday.new(@endpoint) do |client|
      end
    end
  end
end
