# frozen_string_literal: true

class SocialFeedsController < ApplicationController
  def index
    data = SocialAggregator.run
    render json: data.result and return if data.valid? && data.errors.messages.empty?

    render json: 'Error occured', status: 500
  end
end
