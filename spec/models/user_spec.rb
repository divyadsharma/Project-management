require 'rails_helper'

RSpec.describe User, type: :model do
  context "assocations" do
    # it { should have_many(:tasks) }
    # it { should have_many(:developer_projects) }
    # it { should have_many(:users) }
    it 'has many developer_projects' do
      relation = described_class.reflect_on_association(:developer_projects)
      expect(relation.macro).to eq :has_many
    end

    it 'has many projects' do
      relation = described_class.reflect_on_association(:projects)
      expect(relation.macro).to eq :has_many
    end

    it 'has many tasks' do
      relation = described_class.reflect_on_association(:tasks)
      expect(relation.macro).to eq :has_many
    end
  end

  context "model operations" do
    describe '#admin?' do
      it "returns true if user is admin" do
        user = FactoryBot.create(:user, type: 'Admin')
        expect(user.admin?).to be true
      end

      it "returns true if user is developer" do
        user = FactoryBot.create(:user, type: 'Developer')
        expect(user.developer?).to be true
      end

      it "returns false if user is manager" do
        user = FactoryBot.create(:user, type: 'Manager')
        expect(user.admin?).to be false
      end
    end
  end
end
