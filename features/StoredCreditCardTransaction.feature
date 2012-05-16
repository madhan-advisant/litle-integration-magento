Feature: StoredCreditCardTransaction
  Tests to verify stored credit card transactions

  Background:
    Given I am doing cc or echeck transactions
    And I am doing paypage transaction


  @javascript @paypage @wip
  Scenario: Do a successful checkout with stored credit card
    Given I am doing Litle auth
    And I am logged in as "gdake@litle.com" with the password "password"
    When I have "affluentvisa" in my cart
      And I press "Proceed to Checkout"
      And I press "Continue"
      And I press the "3rd" continue button
      And I choose "CreditCard"
      And I select "Visa" from "Credit Card Type"
      And I fill in "Credit Card Number" with "4100000000000001"
      And I select "9" from "Expiration Date"
      And I select "2012" from "creditcard_expiration_yr"
      And I fill in "Card Verification Number" with "123"
      And I press the "4th" continue button
      And I press "Place Order"
    Then I should see "Thank you for your purchase"
    Given I am doing stored creditcard transaction
      When I have "affluentvisa" in my cart
      And I press "Proceed to Checkout"
      And I press "Continue"
      And I press the "3rd" continue button
      And I choose "CreditCard"
      And I select "Stored MC Ending in: 5555" from "creditcard_cc_vaulted"
      And I fill in "Card Verification Number" with "123"
      And I press the "4th" continue button
      And I press "Place Order"
    Then I should see "Thank you for your purchase"
    And I follow "Log Out"
    Given I am logged in as an administrator
    When I view "Sales" "Orders"
      And I click on the top row in Orders
        Then I should see "Order #"
        Then I should see "Litle Credit Card"
        Then I should see "xxxx-5555" in Credit Card Number
        When I view "Sales" "Orders"
        And I press "Create New Order"
        And I click on the customer "Greg Dake" in "Create New Order"
        And I press "Add Products"
        And I click on the top row in Product Table
        And I press "Add Selected Product(s) to Order"
        And I wait for the payments to appear
        And I choose "CreditCard"
    Then I should see "Stored Credit Cards"
    And I follow "Log Out"
    
    
    