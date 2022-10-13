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
    redirect_to sign_up_path unless logged_in?
    # TODO: replace sign_up_path with login_path after adding route and creating view
  end
end
