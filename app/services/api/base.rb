module Api
  class Base
    include Api::HttpStatusCodes
    include Api::ApiExceptions

    def self.call(*args, &block)
      new(*args, &block).call
    end

    def initialize
      @data = {}
      @errors = []
    end

    def call
      begin
        perform
      rescue StandardError => e
        @errors << e
      end

      log_errors if @errors.present?
      Result.new(data: @data, errors: @errors)
    end

    private

    def request(client, http_method:, endpoint:, params: {})
      @response = client.call.public_send(http_method, endpoint, params)
      return (@data = JSON.parse(@response.body)) if response_successful?

      raise error_class, "Code: #{@response.status}, message: #{@response.body}"
    end

    def log_errors
      Rails.logger.info @errors
    end

    # rubocop:disable all
    def error_class
      case @response.status
      when HTTP_BAD_REQUEST_CODE
        BadRequestError
      when HTTP_UNAUTHORIZED_CODE
        UnauthorizedError
      when HTTP_FORBIDDEN_CODE
        ForbiddenError
      when HTTP_NOT_FOUND_CODE
        NotFoundError
      when HTTP_UNPROCESSABLE_ENTITY_CODE
        UnprocessableEntityError
      when HTTP_TIMEOUT
        TimeoutError
      else
        ApiError
      end
    end

    def response_successful?
      @response.status == HTTP_OK_CODE
    end
  end
end
