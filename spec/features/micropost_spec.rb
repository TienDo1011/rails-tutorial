require 'rails_helper'

describe "Micropost" do
  let(:user) { create(:user) }
  before { sign_in user }
  
  describe "micropost creation" do
    before { visit "/" }

    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it "shows error" do
          expect(page).to have_selector('div.alert.alert-danger')
        end
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost-content', with: "Lorem ipsum" }
      it "should create a micropost" do
        click_button "Post"
        expect(page).to have_content("Lorem ipsum")
        page.evaluate_script "window.location.reload()"
        expect(page).to have_content("Lorem ipsum")
      end
    end
  end

  describe "micropost destruction" do
    before { create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        page.accept_confirm do
          click_link "Delete"
        end
        page.evaluate_script "window.location.reload()"
        expect(all(".feed-item").count).to eq(0)
      end
    end
  end
end
