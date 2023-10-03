Feature: Search Available Room
    Background:
        Given "landing_page" loaded
        When I tap the "login_button" button
        And I chill out a bit
        Then I should see "dashboard_page" page
        And I chill out a bit
        Then I tap the "select_meeting_room_button" button
        And I chill out a bit
        Then I should see "search_room_page" page
    Scenario: Search Available Room
        Given "search_room_page" loaded
        When I tap the "search_available_room_button" button
        And I chill out a bit
        Then I should see "room_list_item_706"
        And I chill out a bit
        When I tap the "room_list_item_706" button
        And I chill out a bit
        Then I should see "booking_summary_page" page
        And I chill out a bit
        When I tap the "confirm_booking_room_button" button
        And I chill out for 5 seconds
        Then I should see "booking_result_page" button