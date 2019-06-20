# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/activerecord'
require_relative '../models/phone'
require_relative './list_manager'

module MyTelecom
  class ApiController < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    PHONE_NUMBERS_OFFSET = 1_111_111_111
    PHONE_NUMBERS_LIMIT = 9_999_999_999

    # enable :sessions
    post '/' do
      number = ListManager.new(get_alloted_numbers).allot_number
      halt 500 unless validate(PHONE_NUMBERS_OFFSET + number)

      Phone.create(phone_number_offset: number)
      { allocated_number: (PHONE_NUMBERS_OFFSET + number).to_s }.to_json
    end

    post '/:number' do
      customer_number = params[:number].to_i
      halt 500 unless validate(customer_number)

      list_manager = ListManager.new(get_alloted_numbers)
      number = list_manager.allot_custom_number(customer_number - PHONE_NUMBERS_OFFSET)
      Phone.create(phone_number_offset: number)
      { allocated_number: (PHONE_NUMBERS_OFFSET + number).to_s }.to_json
    end

    def validate(number)
      (number <= PHONE_NUMBERS_LIMIT) && (number >= PHONE_NUMBERS_OFFSET)
    end

    def get_alloted_numbers
      Phone.all.map(&:phone_number_offset)
    end
  end
end
