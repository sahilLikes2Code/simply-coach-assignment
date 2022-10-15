# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { 'Water plants in the evening' }
    due_date { '2022-10-16' }
    status { 0 }
    association :user
  end
end
