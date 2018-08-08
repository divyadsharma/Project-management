require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  it { should use_before_action(:set_task),only: [:show, :update] }
  before do
    @user = FactoryBot.create(:user, type: "Developer")
    @task = FactoryBot.create(:task)
    @project = FactoryBot.create(:project)
    sign_in @user
  end

  describe "GET #index" do
    it "populates an array of tasks to developer" do
      @user.tasks << @task
      @user.save
      get :index, params: {user_id: @user.id}
      assigns(:tasks).should eq([@task])
    end

    it "renders the :index view" do
      get :index, params: {user_id: @user.id}
      response.should render_template :index
    end
  end

  describe "PUT #update" do
    it "update a task" do
      put :update, params: {user_id: @user.id, task:{status: "done"}, task_id: @task.id}
      expect(response).to redirect_to(admin_user_tasks_path(@user))
    end
  end
end
