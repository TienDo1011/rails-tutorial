require 'rails_helper'

describe API::Microposts do
  include Rack::Test::Methods
  
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let!(:micropost) { FactoryBot.create(:micropost, user: user) }

  describe "POST /microposts" do
    context "authorized" do
      before { sign_in user, no_capybara: true }

      it "creates micropost" do
        totalMicropost = Micropost.count
        userMicropostsCount = user.microposts.count
        post "/api/microposts", micropost: { content: "Something" }
        expect(Micropost.count).to eq(totalMicropost + 1)
        expect(user.microposts.count).to eq(userMicropostsCount + 1)
        expect(last_response.status).to eq(201)
      end
    end
  end

  describe "DELETE /microposts/:id" do
    context "authorized" do
      before { sign_in user, no_capybara: true }
      it "destroys micropost" do
        totalMicropost = Micropost.count
        userMicropostsCount = user.microposts.count
        delete "/api/microposts/#{micropost.id}"

        expect(Micropost.count).to eq(totalMicropost - 1)
        expect(user.microposts.count).to eq(userMicropostsCount - 1)
        expect(last_response.status).to eq(200)
      end
    end

    context "not sign in" do
      it "do not destroy micropost" do
        expect do
          delete "/api/microposts/#{micropost.id}"
        end.not_to change(user.microposts, :count)
        expect(last_response.status).to eq(401)
      end
    end

    context "different user" do
      before { sign_in other_user, no_capybara: true }
      it "do not destroy micropost" do
        expect {
          delete "/api/microposts/#{micropost.id}"
        }.not_to change(user.microposts, :count)
        expect(last_response.status).to eq(404)
      end
    end
  end
end