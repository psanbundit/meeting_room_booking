package com.paloit.meeting_room_booking.controller;

import org.hamcrest.Matchers;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import io.restassured.RestAssured;

import static io.restassured.RestAssured.given;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class RoomControllerTest {
    @LocalServerPort
    private int port;

    @BeforeEach
    public void setup() {
        RestAssured.port = port;
    }

    @Test
    public void getRooms_responseSuccess_200() {
        given()
                .log()
                .all()
                .with()
                .when().get("/room")
                .then()
                .statusCode(200)
                .assertThat().body("data.isEmpty()", Matchers.is(false));
    }

    @Test
    public void getRoomById_responseSuccess_200() {
        given()
                .log()
                .all()
                .when().get("/room/706")
                .then()
                .statusCode(200);
    }

    @Test
    public void getRoomById_notFound_404() {
        given()
                .log()
                .all()
                .when().get("/room/999")
                .then()
                .statusCode(404)
                .assertThat().body("errors", Matchers.is("Room not found"));
    }

    // TODO: Search available room list
    // Case not found
    // #1 Overlap start
    @Test
    public void getAvailableRoom_overlapStart_200() {
        given()
                .log()
                .all()
                .when()
                .get("/room/available?startTime=2023-09-20T07:00:00&endTime=2023-09-20T09:00:00")
                .then()
                .statusCode(200)
                .assertThat()
                .body("data.id", Matchers.not(Matchers.hasItem(707)));
    }

    // #2 Overlap end
    @Test
    public void getAvailableRoom_overlapEnd_200() {
        given()
                .log()
                .all()
                .when()
                .get("/room/available?startTime=2023-09-20T09:00:00&endTime=2023-09-20T13:00:00")
                .then()
                .statusCode(200)
                .assertThat()
                .body("data.id", Matchers.not(Matchers.hasItem(707)));
    }

    // #3 Overlap start and end
    @Test
    public void getAvailableRoom_overlapStartAndEnd_200() {
        given()
                .log()
                .all()
                .when()
                .get("/room/available?startTime=2023-09-20T08:00:00&endTime=2023-09-20T13:00:00")
                .then()
                .statusCode(200)
                .assertThat()
                .body("data.id", Matchers.not(Matchers.hasItem(707)));
    }

    // #4 In start and end
    @Test
    public void getAvailableRoom_inStartAndEnd_200() {
        given()
                .log()
                .all()
                .when()
                .get("/room/available?startTime=2023-09-20T09:30:00&endTime=2023-09-20T11:30:00")
                .then()
                .statusCode(200)
                .assertThat()
                .body("data.id", Matchers.not(Matchers.hasItem(707)));
    }

    // #5 Same start and end
    @Test
    public void getAvailableRoom_sameStartAndEnd_200() {
        given()
                .log()
                .all()
                .when()
                .get("/room/available?startTime=2023-09-20T09:00:00&endTime=2023-09-20T12:00:00")
                .then()
                .statusCode(200)
                .assertThat()
                .body("data.id", Matchers.not(Matchers.hasItem(707)));
    }

    // Case found
    // #1 Start before and same as reserved start
    @Test
    public void getAvailableRoom_beforeStartReserved_200() {
        given()
                .log()
                .all()
                .when()
                .get("/room/available?startTime=2023-09-20T07:00:00&endTime=2023-09-20T08:00:00")
                .then()
                .statusCode(200)
                .assertThat()
                .body("data.id", Matchers.hasItem(707));
    }

    // #2 End after and same as reserved start
    @Test
    public void getAvailableRoom_afterEndReserved_200() {
        given()
                .log()
                .all()
                .when()
                .get("/room/available?startTime=2023-09-20T12:00:00&endTime=2023-09-20T15:00:00")
                .then()
                .statusCode(200)
                .assertThat()
                .body("data.id", Matchers.hasItem(707));
    }

    // #3 No overlap time
    @Test
    public void getAvailableRoom_noOverlapReserved_200() {
        given()
                .log()
                .all()
                .when()
                .get("/room/available?startTime=2023-09-20T16:00:00&endTime=2023-09-20T18:00:00")
                .then()
                .statusCode(200)
                .assertThat()
                .body("data.id", Matchers.hasItem(707));
    }

    @AfterEach
    public void tearDown() {

    }
}
