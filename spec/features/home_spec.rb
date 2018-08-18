require 'rails_helper'

describe "Home page" do
  include ApplicationHelper
  
  before { visit "/" }

  describe "for signed-in users" do
    let(:user) { create(:user) }
    before do
      create(:micropost, user: user, content: "Lorem ipsum")
      create(:micropost, user: user, content: "Dolor sit amet")
      sign_in user
      visit "/"
    end

    it "should render the user's feed" do
      user.feed.each do |item|
        expect(page).to have_selector("li", text: item.content)
      end
    end

    describe "follower/following counts" do
      let(:other_user) { create(:user) }
      before do
        other_user.follow!(user.id)
        visit "/"
      end
      
      it "shows links with count" do
        expect(page).to have_content("0 followings")
        expect(page).to have_content("1 followers")
      end
    end
  end
end