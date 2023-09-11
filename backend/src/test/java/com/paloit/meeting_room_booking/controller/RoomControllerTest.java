package com.paloit.meeting_room_booking.controller;

import org.aspectj.lang.annotation.After;
import org.hamcrest.Matcher;
import org.hamcrest.Matchers;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import io.restassured.RestAssured;

import java.util.HashMap;
import java.util.Map;

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
                .when().get("/rooms")
                .then()
                .statusCode(200)
                .assertThat().body("isEmpty()", Matchers.is(false));
    }

    @Test
    public void getRoomById_responseSuccess_200() {
        given()
                .log()
                .all()
                .when().get("/rooms/1")
                .then()
                .statusCode(200);
    }

    @Test
    public void getRoomById_notFound_404() {
        given()
                .log()
                .all()
                .when().get("/rooms/100")
                .then()
                .statusCode(404);
    }

    @Test
    public void createRoom_responseSuccess_201() {

        Map<String,Object> room = new HashMap<>();
        room.put("name", "xyx1111");
        room.put("capacity", 10);

        given()
                .log()
                .all()
                .header("Content-Type", "application/json")
                .body(room)
                .when().post("/rooms/create")
                .then()
                .statusCode(201);
    }

    @Test
    public void createRoom_badRequest_400() {

        given()
                .log()
                .all()
                .header("Content-Type", "application/json")
                .when().post("/rooms/create")
                .then()
                .statusCode(400);
    }

    @AfterEach
    public void tearDown() {

    }
}
