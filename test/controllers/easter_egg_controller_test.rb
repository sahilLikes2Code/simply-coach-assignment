# frozen_string_literal: true

require 'test_helper'

class EasterEggControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get max_sub_array_new_path
    assert_response :success
  end

  test 'should calculate correct maximum sub array in array' do
    post max_sub_array_path, params: { array: '[-1, 2, -3, 1, 0, 3]' }

    assert_response :ok
    assert_equal [1, 0, 3], @response.parsed_body['max_sub_array']
  end

  test 'should raise error if invalid data entered, other than array' do
    post max_sub_array_path, params: { array: 'not an array' }

    assert_equal 'Please enter a valid input', @response.parsed_body['error']
    assert_response :unprocessable_entity
  end
end
