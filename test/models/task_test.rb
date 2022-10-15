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
    @task.name = 'a' * 9

    assert_not @task.valid?
    assert_equal ['is too short (minimum is 10 characters)'], @task.errors[:name]
  end

  test 'due_date should be present' do
    @task.due_date = nil
    assert_not @task.valid?

    assert_includes @task.errors[:due_date], "can't be blank"
  end

  test 'name should be saved as lowercase' do
    mixed_case_task_name = 'I Am A tasK with Random case Of valiD LEngth'
    @task.name = mixed_case_task_name

    @task.save
    assert_equal mixed_case_task_name.downcase, @task.reload.name
  end

  test 'user should be present' do
    @task.user = nil
    assert_not @task.valid?

    assert_includes @task.errors[:user], 'must exist'
  end
end
