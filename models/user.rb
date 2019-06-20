# frozen_string_literal: true

module MyTelecom
  class User < ActiveRecord::Base
    has_secure_password
    EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze

    validates :email, uniqueness: true
    validates :name, uniqueness: true
    validates_format_of :email, with: EMAIL_REGEX, on: :create
  end
end
