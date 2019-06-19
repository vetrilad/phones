# frozen_string_literal: true

require_relative './lib/api_controller'
ENV['RACK_ENV'] ||= 'development'
run MyTelecom::ApiController
