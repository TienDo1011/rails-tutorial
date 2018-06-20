require 'rails_helper'

describe UsersController do
  describe "POST /users" do
    let(:user) { attributes_for(:user) }
    context "with valid info" do
      it "creates user" do
        expect {
          xhr :post, :create, user: user
        }.to change(User, :count).by(1)
      end
    end
  
    context "with invalid info" do
      it "do not create user" do
        user[:password] = "foo"
        user[:password_confirmation] = "foo"
        expect {
          xhr :post, :create, user: user
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
        xhr :patch, :update, id: admin_user.id, user: admin_attributes
        expect(admin_user.reload.name).to eq('Tien do')
      end
    end

    context "not authorized" do
      before { sign_in other_user, no_capybara: true }
      it "do not update user" do
        xhr :patch, :update, id: admin_user.id, user: { name: 'Tien do' }
        expect(admin_user.reload.name).to eq('Tien')
        expect(response.status).to eq(403)
      end
    end
  end

  describe "DELETE /users/:id" do
    context "authorized" do
      before { sign_in admin_user, no_capybara: true }
      it "destroys user" do
        expect {
          xhr :delete, :destroy, id: other_user.id
        }.to change(User, :count).by(-1)
      end
    end

    context "not authorized" do
      before { sign_in other_user, no_capybara: true }
      it "do not destroy user" do
        expect {
          xhr :delete, :destroy, id: other_user.id
        }.not_to change(User, :count)
        expect(response.status).to eq(403)
      end
    end
  end

  describe "POST /users/:id/follow" do
    context "authorized" do
      before { sign_in admin_user, no_capybara: true }
      it "follows user" do
        expect {
          xhr :post, :follow, id: admin_user.id, followed_user_id: other_user.id
        }.to change(admin_user.followed_users, :count).by(1)
      end
    end
  end

  describe "POST /users/:id/unfollow" do
    context "authorized" do
      before { sign_in admin_user, no_capybara: true }
      it "unfollows user" do
        xhr :post, :follow, id: admin_user.id, followed_user_id: other_user.id
        expect {
          xhr :post, :unfollow, id: admin_user.id, unfollowed_user_id: other_user.id
        }.to change(admin_user.followed_users, :count).by(-1)
      end
    end
  end
end