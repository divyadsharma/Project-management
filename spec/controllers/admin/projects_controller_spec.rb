require 'rails_helper'

RSpec.describe Admin::ProjectsController, type: :controller do
  it { should use_before_action(:set_project),only: [:edit, :update, :destroy] }
  before do
    @user = FactoryBot.create(:user, type: "Admin")
    @project = FactoryBot.create(:project)
    sign_in @user
  end

  describe "GET #index" do
    it "populates an array of projects" do
      get :index, params: {user_id: @user.id}
      assigns(:projects).should eq([@project ])
    end

    it "renders the :index view" do
      get :index, params: {user_id: @user.id}
      response.should render_template :index
    end
  end

  describe "POST #create" do
    it "creates a new project" do
      expect{
        post :create, params: {user_id: @user.id, project:{title: "project title", description: "project description", user_ids: [@user.id]}, project_id: @project.id}
      }.to change(Project,:count).by(1)
    end

    it "error creating a project" do
      post :create, params: {user_id: @user.id, project:{title: "", description: "project description", user_ids: [@user.id]}, project_id: @project.id}
      response.should render_template :new
    end
  end

  describe "PUT #update" do
    it "update a project" do
      put :update, params: {user_id: @user.id, project:{title: "project new title"},id: @project.id}
      expect(flash[:notice]).to be_present
      expect(flash[:notice]).to eq('Project was successfully updated.')
      expect(response).to redirect_to(admin_user_projects_path(@user))
    end

    it "error in updating a project" do
      put :update, params: {user_id: @user.id, project:{title: ""},id: @project.id}
      expect(response).to render_template :edit
    end
  end

  describe "DELETE #destroy" do
    it "deletes a project" do
      delete :destroy, params: {id: @project.id, user_id: @user.id}
      expect(flash[:notice]).to be_present
      expect(flash[:notice]).to eq('Project was successfully destroyed.')
      expect(response).to redirect_to(admin_user_projects_path(@user))
    end
  end
end
