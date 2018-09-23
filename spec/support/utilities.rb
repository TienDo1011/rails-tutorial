# include ApplicationHelper

def sign_in(user, options={})
  if options[:no_capybara]
    token = User.token
    user.update_attribute(:digest_token, User.digest(token))
    header "Authorization", "Bearer #{token}"
  else
    visit "/signin"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end