# frozen_string_literal: true

class RegistrationsController < ApplicationController
  skip_before_action :require_login

  def initialize
    super
    @errors = []
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!
      redirect_to root_path, notice: 'Successfully created user!'
    else
      generate_custom_error_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

  def generate_custom_error_messages
    @errors = @user.errors.messages.map { |k, v| "#{k.capitalize} #{v.sort[0]}" }
  end
end
