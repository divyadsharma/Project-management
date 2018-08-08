require 'rails_helper'

RSpec.describe Project, type: :model do
  context "assocations" do
    it { should have_many(:tasks) }
    it { should have_many(:developer_projects) }
    it { should have_many(:users) }
  end

  context "nested attributes" do
    it { should accept_nested_attributes_for(:users) }
    it { should accept_nested_attributes_for(:developer_projects) }
  end

  context "model operations" do

    it "checks project is invalid without title and decription" do
      project = Project.new()
      expect(project.valid?).to eq(false)
    end

    it "checks project is invalid with title only" do
      project = Project.new(title: "Project Title")
      expect(project.valid?).to eq(false)
    end

    it "checks project is valid with all requirements" do
      project = FactoryBot.create(:project)
      expect(project.valid?).to eq(true)
    end

    it "checks title scope" do
      project = FactoryBot.create(:project)
      project_title = Project.title(project.id)
      expect(project_title.include?('Project Title')).to eq(true)
    end
  end
end
