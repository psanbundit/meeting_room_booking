package com.paloit.meeting_room_booking.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
@RestController
@RequestMapping(value = "/user")
public class UserController {

    @GetMapping("/{id}")
    public ResponseEntity<String> getRoomById(){
//        TODO: Get user by id
        return new ResponseEntity<String>("", HttpStatus.OK);
    }

    @PostMapping("")
    public ResponseEntity<Boolean> postCreateRoom(){
//        TODO: Create user
        return new ResponseEntity<Boolean>(true, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Boolean> updateRoomById(){
//        TODO: Update user information
        return new ResponseEntity<Boolean>(true, HttpStatus.NO_CONTENT);
    }

    @DeleteMapping("")
    public ResponseEntity<Boolean> deleteRoomById(){
//        TODO: Delete user by id
        return new ResponseEntity<Boolean>(true, HttpStatus.NO_CONTENT);
    }
}
