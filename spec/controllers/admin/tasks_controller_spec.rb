require 'rails_helper'

RSpec.describe Admin::TasksController, type: :controller do
  it { should use_before_action(:set_task),only: [:edit, :update, :destroy] }
  before do
    @user = FactoryBot.create(:user, type: "Admin")
    @task = FactoryBot.create(:task)
    @project = FactoryBot.create(:project)
    sign_in @user
  end

  describe "GET #index" do
    it "populates an array of tasks" do
      get :index, params: {user_id: @user.id}
      assigns(:tasks).should eq([@task])
    end

    it "renders the :index view" do
      get :index, params: {user_id: @user.id}
      response.should render_template :index
    end
  end

  describe "POST #create" do
    it "creates a new task" do
      expect{
        post :create, params: {user_id: @user.id, task:{title: "task title",
                               description: "task description", complexity: 2,
                               status: "in_progress", project_id: @project.id,
                               user_id: @user.id}, task_id: @task.id}
      }.to change(Task,:count).by(1)
    end

    it "error creating a task" do
      post :create, params: {user_id: @user.id, task:{title: "",
                              description: "task description", complexity: 2,
                              status: "in_progress", project_id: @project.id,
                              user_id: @user.id}, task_id: @task.id}
      response.should render_template :new
    end
  end

  describe "PUT #update" do
    it "update a task" do
      put :update, params: {user_id: @user.id, task:{title: "task updated title"}, id: @task.id}
      expect(flash[:notice]).to be_present
      expect(flash[:notice]).to eq('Task was successfully updated.')
      expect(response).to redirect_to(admin_user_tasks_path(@user))
    end

    it "error in updating a task" do
      put :update, params: {user_id: @user.id, task:{title: ""},id: @task.id}
      expect(response).to render_template :edit
    end
  end

  describe "DELETE #destroy" do
    it "deletes a task" do
      delete :destroy, params: {id: @task.id, user_id: @user.id}
      expect(flash[:notice]).to be_present
      expect(flash[:notice]).to eq('Task was successfully destroyed.')
      expect(response).to redirect_to(admin_user_tasks_path(@user))
    end
  end
end
