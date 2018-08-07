class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update]

  def index
    @tasks = Task.where(user_id: current_user.id)
  end

  def show
  end

  def update
    respond_to do |format|
      if params[:status].present?
        @task.update_attributes(status: params[:status])
      end
      format.js
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end
end
