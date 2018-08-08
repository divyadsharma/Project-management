require 'rails_helper'

RSpec.describe DeveloperProject, type: :model do
  context "assocations" do
    # it { should have_many(:tasks) }
    # it { should have_many(:developer_projects) }
    # it { should have_many(:users) }
    it 'belongs to user' do
      relation = described_class.reflect_on_association(:user)
      expect(relation.macro).to eq :belongs_to
    end

    it 'belongs to project' do
      relation = described_class.reflect_on_association(:project)
      expect(relation.macro).to eq :belongs_to
    end
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
