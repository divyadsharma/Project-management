require 'rails_helper'

RSpec.describe Admin::ProjectsController, type: :controller do
  # it { should use_before_action(:find_address_params),only: [:edit, :update, :destroy] }
  before do 
    @user = FactoryBot.create(:user, type: "Admin")
    # sign_in @user
  end
    
  describe "GET #index" do
    it "populates an array of projects" do
      project = Factory(:project)
      get :index
      assigns(:projects).should eq([project])
    end
    
    it "renders the :index view" do
      get :index
      response.should render_template("admin/projects/index")
    end
  end
end
