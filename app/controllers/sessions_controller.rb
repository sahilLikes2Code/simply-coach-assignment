# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_login

  def initialize
    super
    @errors = []
  end

  def new
    render
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      login!
      redirect_to root_path, notice: 'Logged in successfully'
    else
      generate_error_messages
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    return unless logged_in?

    logout!
    redirect_to root_path, notice: 'Logged out user'
  end

  private

  def generate_error_messages
    @errors =
      if params[:email].empty? && params[:password].empty?
        ["Email can't be blank", "Password can't be blank"]
      elsif params[:email].empty?
        ["Email can't be blank"]
      elsif params[:password].empty?
        ["Password can't be blank"]
      else
        ['Invalid email or password']
      end
  end
end
