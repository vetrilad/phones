# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/activerecord'
require 'bcrypt'

require_relative '../models/phone'
require_relative '../models/user'

require_relative './list_manager'

module MyTelecom
  class ApiController < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    enable :inline_templates
    enable :sessions

    get '/' do
      if current_user
        erb :home
      else
        redirect '/sign_in'
      end
    end

    get '/sign_in' do
      erb :sign_in
    end

    post '/sign_in' do
      user = User.all.find { |u| u.name == params[:username] }
      if user && test_password(params[:password], user.password)
        session.clear
        session[:user_id] = user.id
        redirect '/'
      else
        @error = 'Username or password was incorrect'
        erb :sign_in
      end
    end

    post '/create_user' do
      User.create(
        name: params[:username],
        password: hash_password(params[:password])
      )

      redirect '/'
    end

    post '/sign_out' do
      session.clear
      redirect '/sign_in'
    end

    post '/' do
      number = ListManager.new(get_alloted_numbers).allot_number
      halt 500 unless Phone.validate(Phone.with_offset(number))

      Phone.create(phone_number_offset: number)
      { allocated_number: Phone.with_offset(number).to_s }.to_json
    end

    post '/:number' do
      customer_number = params[:number].to_i
      halt 500 unless Phone.validate(customer_number)

      list_manager = ListManager.new(get_alloted_numbers)
      number = list_manager.allot_custom_number(Phone.without_offset(customer_number))
      Phone.create(phone_number_offset: number)
      { allocated_number: Phone.with_offset(number).to_s }.to_json
    end

    helpers do
      def current_user
        if session[:user_id]
           User.all.find { |u| u.id == session[:user_id] }
        else
          nil
        end
      end

      def get_alloted_numbers
        Phone.all.map(&:phone_number_offset)
      end

      def hash_password(password)
        BCrypt::Password.create(password).to_s
      end

      def test_password(password, hash)
        BCrypt::Password.new(hash) == password
      end
    end
  end
end

__END__

@@ sign_in
  <h1>Sign in</h1>
  <% if @error %>
    <p class="error"><%= @error %></p>
  <% end %>
  <form action="/sign_in" method="POST">
    <input name="username" placeholder="Username" />
    <input name="password" type="password" placeholder="Password" />
    <input type="submit" value="Sign In" />
  </form>

@@ home
  <h1>Home</h1>
  <p>Hello, <%= current_user.name %>.</p>
  <form action="/sign_out" method="POST">
    <input type="submit" value="Sign Out" />
  </form>

  <h2>Create New User</h2>
  <form action="/create_user" method="POST">
    <input name="username" placeholder="Username" />
    <input name="password" placeholder="Password" />
    <input type="submit" value="Create User" />
  </form>

@@ layout
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="utf-8" />
      <title>Simple Authentication Example</title>
      <style>
        input { display: block; }
        .error { color: red; }
      </style>
    </head>
    <body><%= yield %></body>
  </html>
