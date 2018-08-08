require 'rails_helper'

RSpec.describe DeveloperProject, type: :model do
  context "assocations" do
    it { should belong_to(:project) }
    it { should belong_to(:user) }
  end

  context "model operations" do

    it "should make entry in developer project" do
      project = FactoryBot.create(:project)
      user = FactoryBot.create(:user)
      project.users << user
      project.save
      expect(DeveloperProject.last.project_id).to eq(project.id)
      expect(DeveloperProject.last.user_id).to eq(user.id)
    end
  end
end
