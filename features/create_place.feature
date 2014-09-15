Feature: Place Creation
  As an Admin
  I Want to add a new place to the application

  Scenario: successful creation
    Given I'm on the place creation page
     When I add a new place
     Then I should see the page for my newly created place
      And the notice "El nuevo lugar ha sido creado"
