# frozen_string_literal: true

require_relative './lib/api_controller'
require_relative './lib/authentication_controller'

ENV['RACK_ENV'] ||= 'development'

use MyTelecom::AuthenticationController
run MyTelecom::ApiController
