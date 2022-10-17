# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :logged_in?

  include Authenticable
end
