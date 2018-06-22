require 'rails_helper'

describe RelationshipsController do

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  describe "POST /relationships" do
    context "authorized" do
      before { sign_in user, no_capybara: true }

      it "creates relationship" do
        current_count = Relationship.count
        xhr :post, :create, relationship: { followed_id: other_user.id }
        expect(Relationship.count). to eq(current_count + 1)
        expect(response).to be_success
      end
    end

    context "not authorized" do
      it "should not create relationship" do
        xhr :post, :create, relationship: { followed_id: other_user.id }
        expect(response.status).to eq(401)
      end
    end
  end

  describe "DELETE /relationships/:id" do
    context "authorized" do
      before do
        sign_in user, no_capybara: true
        user.follow!(other_user.id)
      end
      let(:relationship) do
        user.relationships.find_by(followed_id: other_user.id)
      end

      it "destroys relationship" do
        current_count = Relationship.count
        xhr :delete, :destroy, id: relationship.id
        expect(Relationship.count).to eq(current_count - 1)
        expect(response).to be_success
      end
    end

    context "not authorized" do
      before { user.follow!(other_user.id) }
      let(:relationship) do
        user.relationships.find_by(followed_id: other_user.id)
      end
      it "should not destroy relationship" do
        xhr :delete, :destroy, id: relationship.id
        expect(response.status).to eq(401)
      end
    end
  end
end