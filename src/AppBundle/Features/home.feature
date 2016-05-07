Feature: Visit homepage
    In order to experience awesomeness
    As a developer
    I should be able to visit the homepage


    Scenario: Visit homepage
        When I go to "/"
        Then I should be on the homepage
        And I should see "Welcome to Symfony"
