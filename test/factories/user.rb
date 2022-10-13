# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Sam' }
    email { 'sam@example.com' }
    password { 'password' }
  end
end
