Feature: Landing Page

    Scenario: As User When i open the app i should see landing page
        Given "landing_page" loaded
        When I tap the "login_button" button
        And I chill out a bit
        Then I should see "search_room_page" page
        And I chill out a bit
        Then I restart the app