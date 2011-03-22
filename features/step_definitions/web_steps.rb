Given /^I visit the "([^"]*)" page$/ do |slug|
  visit Page.find_by_slug(slug).path
end

Given /^I visit "([^"]*)"$/ do |path|
  visit path
end