require 'rails_helper'

RSpec.describe Task, type: :model do
  context "assocations" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end

  context 'enums' do
    it { should define_enum_for(:status).with( [:pending, :in_progress, :done]) }
    let(:status) { [:pending, :in_progress, :done] }
    it 'is not valid with a bad status' do
      expect { build(:task, status: :not_done) }
        .to raise_error(ArgumentError)
        .with_message(/is not a valid status/)
    end

    it 'has the correct status' do
      status.each_with_index do |item, index|
        expect(described_class.statuses[item]).to eq index
      end
    end
  end

  context "model operations" do
    it "checks task is invalid without title and decription" do
      task = Task.new()
      expect(task.valid?).to eq(false)
    end

    it "checks task is invalid with title only" do
      task = Task.new(title: "task Title")
      expect(task.valid?).to eq(false)
    end

    it "checks task is valid with all requirements" do
      task = FactoryBot.create(:task)
      expect(task.valid?).to eq(true)
    end

    describe '.in_progress' do
      it "returns in progress tasks" do
        project = FactoryBot.create(:project)
        task1 = FactoryBot.create(:task)
        task2 = FactoryBot.create(:task, title: "task2 title", status: "in_progress")
        project.tasks << task1
        project.tasks << task2
        project.save
        expect(Task.in_progress(project.tasks)).to eq([task2])
      end
    end

    describe '.done' do
      it "returns in done tasks" do
        project = FactoryBot.create(:project)
        task1 = FactoryBot.create(:task)
        task2 = FactoryBot.create(:task, title: "task2 title", status: "done")
        project.tasks << task1
        project.tasks << task2
        project.save
        expect(Task.done(project.tasks)).to eq([task2])
      end
    end

    describe '.pending' do
      it "returns in pending tasks" do
        project = FactoryBot.create(:project)
        task1 = FactoryBot.create(:task, status: "done")
        task2 = FactoryBot.create(:task, title: "task2 title", status: "pending")
        project.tasks << task1
        project.tasks << task2
        project.save
        expect(Task.pending(project.tasks)).to eq([task2])
      end
    end

    describe '.projects' do
      it "returns projects" do
        project1 = FactoryBot.create(:project)
        project2 = FactoryBot.create(:project)
        task1 = FactoryBot.create(:task, project: project1)
        task2 = FactoryBot.create(:task, project: project2)
        task3 = FactoryBot.create(:task, project: project1)
        expect(Task.projects(project1.id)).to eq([task1, task3])
      end
    end

    describe '.pie_data' do
      it "returns pie chart data" do
        task1 = FactoryBot.create(:task, status: "done")
        task2 = FactoryBot.create(:task, status: "pending")
        task3 = FactoryBot.create(:task, status: "in_progress")
        project = FactoryBot.create(:project)
        project.tasks << task1
        project.tasks << task2
        project.tasks << task3
        project.save
        pie_data = Task.pie_data(project.tasks)
        expect(pie_data).to include(["In Progress", 1])
      end
    end
  end
end
