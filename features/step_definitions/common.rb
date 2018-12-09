And /(I|He) click on the "([\w\s]+)" button/ do |_, text|
  click_button text
end

And /I see the "([\w\s]+)" button/ do |text|
  expect(page).to have_content(text)
end

And /I do not see error/ do
  expect(page).to have_no_selector('div.alert.alert-danger')
end

And /^I see error$/ do
  expect(page).to have_selector('div.alert.alert-danger')
end

Then(/^I see "([\w\s]+)"$/) do |text|
  expect(page).to have_content(text)
end

And(/I do not see "(\w+)" link/) do |text|
  expect(page).to have_no_link(text)
end

And(/^I see "([\w\s]+)" link$/) do |text|
  expect(page).to have_link(text)
end

When(/I click on "([\w\s]+)" link/) do |text|
  click_link(text)
end
