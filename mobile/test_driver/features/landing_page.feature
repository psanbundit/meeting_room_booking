Feature: See Landing Page
    Background: See Buttons
        Given "landing_page" loaded
        Then I should see "login_button" button
        And I should see "signup_button" button
        And I chill out a bit
    Scenario: Test Buttons clickability
        When I tap the "login_button" button
        And I chill out a bit
        Then I should see "dashboard_page" page
        And I chill out a bit
        And I restart the app