require 'rails_helper'

describe RelationshipsController do

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  describe "User are authorized" do
    before { sign_in user, no_capybara: true }

    describe "creating a relationship with Ajax" do
      it "should increment the Relationship count" do
        expect do
          xhr :post, :create, relationship: { followed_id: other_user.id }
        end.to change(Relationship, :count).by(1)
      end
  
      it "should respond with success" do
        xhr :post, :create, relationship: { followed_id: other_user.id }
        expect(response).to be_success
      end
    end
  
    describe "destroying a relationship with Ajax" do
      before { user.follow!(other_user) }
      let(:relationship) do
        user.relationships.find_by(followed_id: other_user.id)
      end
  
      it "should decrement the Relationship count" do
        expect do
          xhr :delete, :destroy, id: relationship.id
        end.to change(Relationship, :count).by(-1)
      end
  
      it "should respond with success" do
        xhr :delete, :destroy, id: relationship.id
        expect(response).to be_success
      end
    end
  end

  describe "User are not authorized" do
    before { user.follow!(other_user) }
    let(:relationship) do
      user.relationships.find_by(followed_id: other_user.id)
    end
    it "should responde with error" do
      xhr :post, :create, relationship: { followed_id: other_user.id }
      expect(response.status).to eq(401)
      xhr :delete, :destroy, id: relationship.id
      expect(response.status).to eq(401)
    end
  end

end