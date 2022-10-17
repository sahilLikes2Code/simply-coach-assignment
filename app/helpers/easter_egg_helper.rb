# frozen_string_literal: true

module EasterEggHelper
  def easter_egg_path?
    request.path == '/easter_egg'
  end
end
