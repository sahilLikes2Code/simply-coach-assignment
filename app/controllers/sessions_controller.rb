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
      flash.now[:notice] = 'Logged in successfully'
      redirect_to root_path
    else
      generate_error_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def generate_error_messages
    if params[:email].empty? && params[:password].empty?
      @errors.push("Email can't be blank", "Password can't be blank")
    elsif params[:email].empty?
      @errors.push("Email can't be blank")
    elsif params[:password].empty?
      @errors.push("Password can't be blank")
    else
      @errors.push('Invalid email or password')
    end
  end
end
