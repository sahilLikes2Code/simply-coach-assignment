# frozen_string_literal: true

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = build :task
  end

  test 'task should be valid' do
    assert @task.valid?
  end

  test 'name should be present' do
    @task.name = ''
    assert_not @task.valid?

    assert_includes @task.errors[:name], "can't be blank"
  end

  test 'name should be of valid length' do
    @task.name = 'a' * 3

    assert_not @task.valid?
    assert_equal ['is too short (minimum is 4 characters)'], @task.errors[:name]
  end

  test 'due_date should be present' do
    @task.due_date = nil
    assert_not @task.valid?

    assert_includes @task.errors[:due_date], "can't be blank"
  end

  test 'user should be present' do
    @task.user = nil
    assert_not @task.valid?

    assert_includes @task.errors[:user], 'must exist'
  end
end
