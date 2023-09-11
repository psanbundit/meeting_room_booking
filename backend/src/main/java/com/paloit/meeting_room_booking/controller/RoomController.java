package com.paloit.meeting_room_booking.controller;

import com.paloit.meeting_room_booking.dbmodel.Room;
import com.paloit.meeting_room_booking.request.RoomRequest;
import com.paloit.meeting_room_booking.service.RoomService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
public class RoomController {
    private RoomService roomService;

    public  RoomController(RoomService roomService) { this.roomService = roomService;}

    @GetMapping("/rooms")
    public List<Room> getAllRoom () {
        return roomService.getRooms();
    }

    @GetMapping("/rooms/{id}")
    public ResponseEntity<Room> getRoomById(@PathVariable Long id) {
        Optional<Room> room = roomService.getRoomById(id);
        return room.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping("/rooms/create")
    public ResponseEntity createRoom(@RequestBody RoomRequest request) {
        Room response = roomService.createRoom(request);
        return  ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @PutMapping("/rooms/{id}") // alternative ("/room/{id}/update)
    public ResponseEntity updateRoom(@PathVariable Long id, @RequestBody RoomRequest request) {

        if (request == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        };

        Optional<Room> room = roomService.getRoomById(id);

        if (room.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        Room updatedRoom = roomService.updateRoom(id ,request);
        return ResponseEntity.status(HttpStatus.OK).body(updatedRoom);
    }

    @DeleteMapping("/rooms/{id}") // alternative ("/room/{id}/deletes)
    public ResponseEntity deleteRoom(@PathVariable Long id) {

        Optional<Room> room = roomService.getRoomById(id);

        HashMap<String, Object> data = new HashMap<String, Object>();

        if(room.isPresent()) {
            roomService.deleteRoom(id);

            data.put("code", HttpStatus.ACCEPTED);
            data.put("message", "OK");

            return ResponseEntity.status(HttpStatus.ACCEPTED).body(data);
        } else {

            data.put("code", HttpStatus.NOT_FOUND);
            data.put("message", "NOT Found id");

            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(data);
        }
    }
}
