# frozen_string_literal: true

module TasksHelper
  def new_task_path?
    request.path == new_task_path
  end
end
