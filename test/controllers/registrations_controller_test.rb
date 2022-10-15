# frozen_string_literal: true

require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    create :user
  end

  test 'should create a user with valid name, email, password and password_confirmation' do
    get sign_up_path
    assert_response :success

    assert_difference 'User.count', 1 do
      post sign_up_path, params: {
        user: {
          name: 'oliver',
          email: 'oliver@example.com',
          password: 'welcome',
          password_confirmation: 'welcome'
        }
      }

      assert_equal 'Successfully created user!', flash.notice
      assert_response :redirect
      follow_redirect!
      assert_redirected_to tasks_path
    end
  end

  test 'should raise error when empty fields are submitted' do
    get sign_up_path
    assert_response :success

    post sign_up_path, params: {
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: ''
      }
    }
    assert_equal [
      "Email can't be blank",
      'Email is invalid',
      'Name is too short (minimum is 3 characters)',
      "Name can't be blank",
      "Password can't be blank",
      'Password is too short (minimum is 6 characters)'
    ],
                 assigns(:user).errors.full_messages
    assert_response :unprocessable_entity
    assert_template :new
  end

  test 'should raise error and redirect to new when trying to create user without/blank name field' do
    get sign_up_path
    assert_response :success

    assert_no_difference 'User.count' do
      post sign_up_path, params: {
        user: {
          name: '',
          email: 'oliver@example.com',
          password: 'welcome',
          password_confirmation: 'welcome'
        }
      }

      assert_equal ['is too short (minimum is 3 characters)', "can't be blank"], assigns(:user).errors[:name]
      assert_response :unprocessable_entity
      assert_template :new
    end
  end

  test 'should raise error and redirect to new when trying to create user without/blank email field' do
    get sign_up_path
    assert_response :success

    assert_no_difference 'User.count' do
      post sign_up_path, params: {
        user: {
          name: 'oliver',
          email: '',
          password: 'welcome',
          password_confirmation: 'welcome'
        }
      }

      assert_equal ["can't be blank", 'is invalid'], assigns(:user).errors[:email]
      assert_response :unprocessable_entity
      assert_template :new
    end
  end

  test 'should raise error and redirect to new when trying to create user without/blank password field' do
    get sign_up_path
    assert_response :success

    assert_no_difference 'User.count' do
      post sign_up_path, params: {
        user: {
          name: 'oliver',
          email: 'oliver@example.com',
          password: '',
          password_confirmation: 'password'
        }
      }

      assert_equal ["can't be blank", 'is too short (minimum is 6 characters)'],
                   assigns(:user).errors[:password]
      assert_response :unprocessable_entity
      assert_template :new
    end
  end

  test 'should raise error and redirect to new when trying to create user with existing email' do
    get sign_up_path
    assert_response :success

    assert_no_difference 'User.count' do
      post sign_up_path, params: {
        user: {
          name: 'sam',
          email: 'sam@example.com',
          password: 'welcome',
          password_confirmation: 'welcome'
        }
      }

      assert_equal ['has already been taken'], assigns(:user).errors[:email]
      assert_response :unprocessable_entity
      assert_template :new
    end
  end

  test 'should raise error and redirect to new when trying to create user with different password and password_confirmation' do
    get sign_up_path
    assert_response :success

    assert_no_difference 'User.count' do
      post sign_up_path, params: {
        user: {
          name: 'oliver',
          email: 'oliver@example.com',
          password: 'password',
          password_confirmation: 'different_password'
        }
      }

      assert_equal ["doesn't match Password"], assigns(:user).errors[:password_confirmation]
      assert_response :unprocessable_entity
      assert_template :new
    end
  end
end
