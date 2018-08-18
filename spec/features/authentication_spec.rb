require 'rails_helper'

describe "Authentication" do
  describe "signin" do
    before { visit "/signin" }

    describe "with invalid information" do
      before { click_button "Sign in" }
      it "shows error" do
        expect(page).to have_content("Sign in")
        expect(page).to have_selector('div.alert.alert-danger')
      end

      describe "after visiting another page" do
        before { click_link "Home" }
        it "clears error" do
          expect(page).not_to have_selector('div.alert.alert-danger')
        end
      end
    end

    describe "with valid information" do
      let(:user) { create(:user) }
      before do
        sign_in user
      end
      it "shows navbar for login user" do
        expect(page).to have_content('Account')
        expect(page).not_to have_content('Sign in')
      end

      describe "followed by signout" do
        before do
          click_on "Account"
          click_on "Sign out"
        end
        it "show Sign in" do
          expect(page).to have_content('Sign in')
        end
      end
    end

    describe "authorization" do
      describe "for non-signed-in users" do
        let(:user) { create(:user) }

        describe "when attempting to visit a protected page" do
          before do
            visit "/users/#{user.id}/edit"
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Sign in"
          end

          describe "after signing in" do
            it "should render the desired protected page" do
              expect(page).to have_content('Update your profile')
              page.execute_script("localStorage.clear()")
            end
          end
        end

        describe "users relating pages" do
          describe "visiting the followings page" do
            before {visit "users/#{user.id}/followings" }
            it "redirect to sign in" do
              expect(page).to have_content('Sign in')
            end
          end

          describe "visiting the followers page" do
            before {visit "users/#{user.id}/followers" }
            it "redirect to sign in" do
              expect(page).to have_content('Sign in')
            end
          end

          describe "visiting the users index" do
            before { visit "/users" }
            it "redirect to sign in" do
              expect(page).to have_content('Sign in')
            end
          end
        end
      end
    end
  end
end
