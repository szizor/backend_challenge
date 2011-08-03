Given /^I have contacts titled (.+)$/ do |titles|
  titles.split(', ').each do |title|
    Contact.create!(:title => title)
  end
end

Given /^I have no contacts$/ do
  Contact.delete_all
end

Then /^I should have ([0-9]+) contacts?$/ do |count|
  Contact.count.should == count.to_i
end

Given /^I have a contact named "([^"]*)" with an last_name "([^"]*)"$/ do |name, last|
  Contact.new(:first_name => name,
            :last_name => last).save!
end

