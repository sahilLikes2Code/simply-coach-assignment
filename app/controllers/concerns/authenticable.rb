# frozen_string_literal: true

module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :require_login
    before_action :redirect_to_root_path_if_logged_in
  end

  def logged_in?
    !!session[:user_id]
  end

  def login!
    session[:user_id] = @user.id
  end

  def logout!
    session.clear
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

  def require_login
    redirect_to login_path unless logged_in?
  end

  def redirect_to_root_path_if_logged_in
    redirect_to root_path if logged_in? && requested_path_login_or_signup?
  end

  def requested_path_login_or_signup?
    request.path == '/login' || request.path == '/sign_up'
  end
end
