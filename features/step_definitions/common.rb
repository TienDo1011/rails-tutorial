And /I click on the "([\w\s]+)" button/ do |text|
  click_button text
end

And /I see the "([\w\s]+)" button/ do |text|
  expect(page).to have_content(text)
end

And /I do not see error/ do
  expect(page).to have_no_selector('div.alert.alert-danger')
end

And /I see error/ do
  expect(page).to have_selector('div.alert.alert-danger')
end
