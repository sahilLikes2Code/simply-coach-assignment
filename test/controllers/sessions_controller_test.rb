# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    create :user
  end

  test 'should be able to login with correct email and password' do
    get login_path
    assert_response :success

    post login_path, params: {
      email: 'sam@example.com',
      password: 'password'
    }

    assert_equal 'Logged in successfully', flash.notice
    assert_response :redirect
    follow_redirect!
    assert_redirected_to tasks_path
  end

  test 'should not login and raise error with incorrect email and password' do
    get login_path
    assert_response :success

    post login_path, params: {
      email: 'sam@example.com',
      password: 'wrong_password'
    }

    assert_equal 'Invalid email or password', flash.notice
    assert_response :unprocessable_entity
    assert_template :new
  end

  test 'should raise error if form submitted with blank email and password' do
    get login_path
    assert_response :success

    post login_path, params: {
      email: '',
      password: ''
    }

    assert_equal ["Email can't be blank", "Password can't be blank"], assigns(:errors)
    assert_response :unprocessable_entity
    assert_template :new
  end

  test 'should raise error if form submitted with blank email' do
    get login_path
    assert_response :success

    post login_path, params: {
      email: '',
      password: 'password'
    }

    assert_equal "Email can't be blank", flash.notice
    assert_response :unprocessable_entity
    assert_template :new
  end

  test 'should raise error if form submitted with blank password' do
    get login_path
    assert_response :success

    post login_path, params: {
      email: 'sam@example.com',
      password: ''
    }

    assert_equal "Password can't be blank", flash.notice
    assert_response :unprocessable_entity
    assert_template :new
  end
end
