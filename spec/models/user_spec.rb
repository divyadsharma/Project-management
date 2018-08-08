require 'rails_helper'

RSpec.describe User, type: :model do
  context "assocations" do
    it { should have_many(:tasks) }
    it { should have_many(:developer_projects) }
    it { should have_many(:users) }
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
