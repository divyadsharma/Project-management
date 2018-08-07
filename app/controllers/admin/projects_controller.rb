class Admin::ProjectsController < Admin::BaseController
  before_action :set_project, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all.paginate(page: params[:page], per_page: 20)
  end

  def new
    @project = Project.new
    @project.developer_projects.build
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to admin_user_projects_path(current_user), notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to admin_user_projects_path(current_user), notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to admin_user_projects_path(current_user), notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :description, user_ids:[])
    end
end
