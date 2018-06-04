require 'rails_helper'

describe MicropostsController do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let!(:micropost) { FactoryBot.create(:micropost, user: user) }

  describe "User are authorized" do
    before { sign_in user, no_capybara: true }

    describe "creating a micropost" do
      it "should increment the micropost" do
        totalMicropost = Micropost.count
        userMicropostsCount = user.microposts.count
        xhr :post, :create, micropost: { content: "Something" }

        expect(Micropost.count).to eq(totalMicropost + 1)
        expect(user.microposts.count).to eq(userMicropostsCount + 1)
        expect(response.status).to eq(200)
      end
    end

    describe "destroying a micropost" do
      it "should decrement the micropost" do
        totalMicropost = Micropost.count
        userMicropostsCount = user.microposts.count
        xhr :delete, :destroy, id: micropost.id

        expect(Micropost.count).to eq(totalMicropost - 1)
        expect(user.microposts.count).to eq(userMicropostsCount - 1)
        expect(response.status).to eq(200)
      end
    end
  end

  describe "User are not authorized" do
    describe "user are not signed in" do
      it "should not let user delete the micropost" do
        expect do
          xhr :delete, :destroy, id: micropost.id
        end.not_to change(user.microposts, :count)
        expect(response.status).to eq(401)
      end
    end

    describe "different user" do
      before { sign_in other_user, no_capybara: true }
      it "should not let user delete the micropost" do
        expect {
          xhr :delete, :destroy, id: micropost.id
        }.not_to change(user.microposts, :count)
        expect(response.status).to eq(403)
      end
    end
  end
end