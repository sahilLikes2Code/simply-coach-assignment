# frozen_string_literal: true

module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :require_login
  end

  def logged_in?
    !!session[:user_id]
  end

  def login!
    session[:user_id] = @user.id
  end

  def current_user
    @current_user ||= User.find(params[:user_id]) if params[:user_id]
  end

  private

  def require_login
    redirect_to login_path unless logged_in?
  end
end
