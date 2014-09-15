Feature: Place Edit
  As an Admin
  I Want to edit an place in the application

  Scenario: successful edit
    Given I'm on the place edit page
     When I change the place data
     Then I should see the page for my newly edited place
      And the notice "El lugar ha sido actualizado"
