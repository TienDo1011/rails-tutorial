require 'rails_helper'

describe Relationship do
  let(:follower) { create(:user) }
  let(:followed) { create(:user) }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  subject {relationship }

  it { should be_valid }

  describe "follower methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
    it "its" do
      expect(subject.follower).to eq(follower)
      expect(subject.followed).to eq(followed)
    end
  end

  describe "when followed id is not present" do
    before { relationship.followed_id = nil }
    it { should_not be_valid }
  end

  describe "when follower id is not present" do
    before { relationship.follower_id = nil }
    it { should_not be_valid }
  end
end
