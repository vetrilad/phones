# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: MyTelecom::User do
    name { 'admin' }
    email  { 'joe@gmail.com' }
  end
end
