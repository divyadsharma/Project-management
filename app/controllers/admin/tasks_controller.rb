class Admin::TasksController < Admin::BaseController
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.all.paginate(page: params[:page], per_page: 20)
  end

  def new
    @task = Task.new
  end

  def edit
    @developer = @task.try(:user)
    @project = @task.try(:project)
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to admin_user_tasks_path(current_user), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to admin_user_tasks_path(current_user), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to admin_user_tasks_path(current_user), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def list_project_developers
    if params[:project_id].present?
      @developers = Project.find_by_id(params[:project_id]).users
      respond_to do |format|
        format.js
      end
    end
  end

  def developer_task_list
  end

  def project_task_list
  end

  def pie_data
    if params[:project].present?
      @project_title = Project.title(params[:project])
      @tasks = Task.projects(params[:project])
      @task_data = Task.pie_data(@tasks)
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :complexity,
                                   :status, :project_id, :user_id)
    end
end
