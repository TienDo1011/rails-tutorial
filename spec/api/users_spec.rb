require 'rails_helper'

describe API::Users do
  include Rack::Test::Methods

  describe "POST /users" do
    let(:user) { attributes_for(:user) }
    context "with valid info" do
      it "creates user" do
        expect {
          post "api/users", user: user
        }.to change(User, :count).by(1)
      end
    end
  
    context "with invalid info" do
      it "do not create user" do
        user[:password] = "foo"
        user[:password_confirmation] = "foo"
        expect {
          post "/api/users", user: user
        }.not_to change(User, :count)
      end
    end
  end

  let!(:admin_attributes) { attributes_for(:admin, name: 'Tien') }
  let!(:admin_user) { User.create(admin_attributes) }
  let!(:other_user) { create(:user) }
  describe "PATCH /users/:id" do
    context "authorized" do
      before { sign_in admin_user, no_capybara: true }
      it "updates user" do
        admin_attributes[:name] = 'Tien do'
        patch "/api/users/#{admin_user.id}", user: admin_attributes
        expect(admin_user.reload.name).to eq('Tien do')
      end
    end

    context "not authorized" do
      it "do not update user" do
        patch "/api/users/#{admin_user.id}", user: { name: 'Tien do' }
        expect(admin_user.reload.name).to eq('Tien')
        expect(last_response.status).to eq(403)
      end
    end
  end

  describe "DELETE /users/:id" do
    context "authorized" do
      before { sign_in admin_user, no_capybara: true }
      it "destroys user" do
        expect {
          delete "api/users/#{other_user.id}"
        }.to change(User, :count).by(-1)
      end
    end

    context "not authorized" do
      before { sign_in other_user, no_capybara: true }
      it "do not destroy user" do
        expect {
          delete "/api/users/#{other_user.id}"
        }.not_to change(User, :count)
        expect(last_response.status).to eq(403)
      end
    end
  end

  describe "POST /users/follow" do
    context "authorized" do
      before { sign_in admin_user, no_capybara: true }
      it "follows user" do
        expect {
          post "/api/users/follow", id: other_user.id
        }.to change(admin_user.followed_users, :count).by(1)
      end
    end
  end

  describe "POST /users/unfollow" do
    context "authorized" do
      before { sign_in admin_user, no_capybara: true }
      it "unfollows user" do
        post "/api/users/follow", id: other_user.id
        expect {
          post "/api/users/unfollow", id: other_user.id
        }.to change(admin_user.followed_users, :count).by(-1)
      end
    end
  end
end