# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/activerecord'

require_relative '../models/user'

module MyTelecom
  class AuthenticationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    enable :sessions

    post '/sign_in' do
      user = User.find_by(name: params[:username])

      if user&.authenticate(params[:password])
        session.clear
        session[:user_id] = user.id
        200
      else
        401
      end
    end

    post '/create_user' do
      user = User.new(
        name: params[:username],
        email: params[:email],
        password: params[:password]
      )
      user.save ? 201 : halt
    end
  end
end
