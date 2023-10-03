Feature: See Dashboard Page
    Background:
        Given "landing_page" loaded
        When I tap the "login_button" button
        And I chill out a bit
        Then I should see "dashboard_page" page
        And I chill out a bit

    Scenario: See Select Meeting Room Button
        And I should see "select_meeting_room_button" button
        And I should see "my_bookings_button" button
        Then I restart the app