class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update]

  def index
    @tasks = Task.where(user_id: current_user.id)
  end

  def show
  end

  def update
    if params[:status].present? || params[:complexity].present?
      @task.update_attributes(status: params[:status], complexity: params[:complexity])
      @success = true
    end
  end

  private
    def set_task
      @task = Task.find(params[:task_id] || params[:id])
    end
end
