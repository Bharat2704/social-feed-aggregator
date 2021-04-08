module Api
  class Base
    include Api::HttpStatusCodes
    include Api::ApiExceptions
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

    def log_errors
      Rails.logger.info @errors
    end

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
      else
        ApiError
      end
    end

    def response_successful?
      @response.status == HTTP_OK_CODE
    end
  end
end