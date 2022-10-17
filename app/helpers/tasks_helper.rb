# frozen_string_literal: true

module TasksHelper
  def edit_task_path?
    request.path.include?('edit')
  end
end
