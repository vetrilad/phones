# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/activerecord'

require_relative '../models/phone'
require_relative '../models/user'
require_relative './list_operator'
require_relative './operator_service_helper'

module MyTelecom
  class ApiController < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    helpers MyTelecom::OperatorServiceHelper

    enable :sessions

    before do
      halt 401 unless session[:user_id] && User.find(session[:user_id])
    end

    post '/?:number?' do
      phone_number = allocate_phone_number(params[:number])
      persist_phone_number(phone_number)
      present_phone_number(phone_number)
    end
  end
end
