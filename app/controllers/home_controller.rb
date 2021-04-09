class HomeController < ApplicationController
  def index
    data = SocialAggregator.run
    render json: data.result and return  if data.valid? && data.errors.messages.empty?
    render json: "Error occured", status: 500
  end
end
