And(/No new micropost has been created/) do
  expect(Micropost.count).to eq(0)
end

When(/I fill in post content/) do
  fill_in 'micropost-content', with: "Lorem ipsum"
end

Then(/I (still )?see my new post/) do |_|
  expect(page).to have_content("Lorem ipsum")
end

When(/I refresh the page/) do
  page.evaluate_script "window.location.reload()"
end

Given(/I have a micropost/) do
  @post = create(:micropost, user: @user)
end

Then(/I (still )?do not see my post/) do |_|
  expect(page).to have_no_content(@post.content)
end

Then(/I see my post/) do
  expect(page).to have_content(@post.content)
end

When(/I click on delete/) do
  page.accept_confirm do
    click_link "Delete"
  end
end

And /I see the number of post updated/ do
  expect(page).to have_content("1 micropost")
end

And /The post input is cleared/ do
  expect(find("#micropost-content").value).to eq("")
end
