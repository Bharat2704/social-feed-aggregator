# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
abort('production mode!') if Rails.env.production?

RSpec.configure do |config|
  config.filter_rails_from_backtrace!
  config.use_active_record = false
  config.infer_spec_type_from_file_location!
end
