package com.paloit.meeting_room_booking.controller;

import io.restassured.RestAssured;
import org.hamcrest.Matchers;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;

import static io.restassured.RestAssured.given;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class BookingControllerTest {

    @LocalServerPort
    private int port;

    @BeforeEach
    public void setup(){
        RestAssured.port = port;
    }

    @Test
    public void postBooking_badRequest_200(){
        given()
                .log()
                .all()
                .with()
                .when().post("/booking/752")
                .then()
                .statusCode(400).assertThat().body("errors", Matchers.is("Form is not valid"));
    }
}
