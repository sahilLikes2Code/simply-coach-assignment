# frozen_string_literal: true

class Api::EasterEggController < ApplicationController
  skip_before_action :require_login
  before_action :logout!

  def initialize
    super
    @user_input = []
  end

  def new; end

  def find_max
    return unless valid_user_input?

    service = MaxSubArrayService.new(@user_input)
    result = service.process

    render json: { max_sub_array: result }, status: :ok
  end

  private

  def valid_user_input?
    @user_input = JSON.parse(params[:array])
    true
  rescue JSON::ParserError
    render json: { error: 'Please enter a valid input' }, status: :unprocessable_entity
    false
  end
end
