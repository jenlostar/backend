Given(/^I am on the home page$/) do
  visit "/"
end

Then(/^I should see "(.*?)"$/) do |string|
  page.has_content?(string).must_equal true
end
