# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/activerecord'
require_relative '../models/phone'
require_relative './list_manager'

module MyTelecom
  class ApiController < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    PHONE_NUMBERS_OFFSET = 1_111_111_111

    post '/' do
      phones = Phone.all.map(&:phone_number_offset)
      number = ListManager.new(phones).allot_number
      Phone.create(phone_number_offset: number)
      { allocated_number: (PHONE_NUMBERS_OFFSET + number).to_s }.to_json
    end

    post '/:number' do
      phones = Phone.all.map(&:phone_number_offset)
      number = ListManager.new(phones).allot_custom_number(params[:number].to_i - PHONE_NUMBERS_OFFSET)
      Phone.create(phone_number_offset: number)
      { allocated_number: (PHONE_NUMBERS_OFFSET + number).to_s }.to_json
    end
  end
end
