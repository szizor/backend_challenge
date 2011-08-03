Feature: create
  In order to create contacts
  As a user
  I want to be able to create valid contacts

Background:
      Given I am a user named "foo" with an email "user@test.com" and password "please"
      And I sign in as "user@test.com/please"
      And I should be signed in
      And I am on the dashboard page
      When I follow "New Contact"
      And I fill in "First name" with "Alex"

@javascript
Scenario: Create Valid Contacts
    And I have no contacts
    And I fill in "Last name" with "Arzola"
    And I press "Save"
    Then I should see "Contact Created"
    And I should see "Alex"
    And I should see "Arzola"
    And I should have 1 contact

@javascript
Scenario: Duplicate Names
    And I have a contact named "Alex" with an last_name "Arzola"
    And I fill in "Last name" with "Arzola"
    And I press "Save"
    Then I should see "First name has already been taken"

@javascript
Scenario: Empty Last Name
    And I fill in "Last name" with ""
    And I press "Save"
    Then I should see "Last name can't be blank"

@javascript
Scenario: Fill address
    And I have no contacts
    And I fill in "Last name" with "Arzola"
    And I follow "Add Addresses"
    And I fill in "Address" with "calle"
    And I fill in "Zip" with "64000"
    And I fill in "City" with "monterrey"
    And I fill in "State" with "Nuevo Leon"
    And I fill in "Country" with "Mexico"
    And I press "Save"
    Then I should see "Contact Created"
    And I should see "Alex"
    And I should see "Arzola"
    And I should have 1 contact

