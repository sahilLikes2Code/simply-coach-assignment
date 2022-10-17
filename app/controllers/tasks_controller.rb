# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update destroy]

  def initialize
    super
    @errors = []
  end

  def index
    @tasks = current_user.tasks.order('due_date ASC')
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: 'Successfully created Task!'
    else
      generate_custom_error_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Successfully Updated Task!'
    else
      redirect_to tasks_path, notice: 'Something went wrong. Please try again!'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :due_date, :status)
  end

  def generate_custom_error_messages
    @errors = @task.errors.messages.map { |k, v| "#{k.capitalize} #{v.sort[0]}" }
  end
end
