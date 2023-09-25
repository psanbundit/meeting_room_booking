package com.paloit.meeting_room_booking.controller;

import com.paloit.meeting_room_booking.model.FormRoom;
import com.paloit.meeting_room_booking.model.Room;
import com.paloit.meeting_room_booking.response.BaseResponse;
import com.paloit.meeting_room_booking.service.RoomService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(value = "/room")
public class RoomController {

    @Autowired
    private RoomService roomService;

    @GetMapping("")
    public ResponseEntity<BaseResponse<List<Room>>> getAllRoom(){
        List<Room> list = this.roomService.getAllRoom();
        BaseResponse<List<Room>> response = new BaseResponse<>();
        return  ResponseEntity.status(HttpStatus.OK).body(response.setData(list));
    }

    @GetMapping("/available")
    public ResponseEntity<BaseResponse<List<Room>>> getAvailableRoom(@RequestParam("startTime") LocalDateTime startTime, @RequestParam("endTime") LocalDateTime endTime){
        BaseResponse<List<Room>> response = new BaseResponse<>();
        if(startTime == null || endTime == null){
            response.setError("Start time and end time must not be null");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        List<Room> list = this.roomService.getAvailableRoomsInPeriod(startTime, endTime);
        response.setData(list);
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<Optional<Room>>> getRoomById(@PathVariable Long id){
        Optional<Room> room = this.roomService.getById(id);
        BaseResponse<Optional<Room>> response = new BaseResponse<>();
        if(room.isEmpty()){
            response.setError("Room not found");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }
        response.setData(room);
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }

    @PostMapping("")
    public ResponseEntity<BaseResponse<Room>> postCreateRoom(@ModelAttribute @Valid Room formRoom, BindingResult bindingResult){
        BaseResponse<Room> response = new BaseResponse<>();
        if(bindingResult.hasErrors()){
            response.setError("Binding error");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        Room room = this.roomService.createRoom(formRoom);
        if(room == null){
            response.setError("Create room error");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }
        response.setData(room);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @PutMapping("/{id}")
    public ResponseEntity<BaseResponse<Room>> updateRoomById(@PathVariable Long id, @ModelAttribute @Valid FormRoom formRoom, BindingResult bindingResult){
        BaseResponse<Room> response = new BaseResponse<>();
        if(id <= 0){
            response.setError("Id must be greater than 0");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        if(bindingResult.hasErrors()){
            response.setError("Binding error");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        Room room = this.roomService.updateRoom(id, formRoom);
        if(room == null){
            response.setError("Update room error");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }
        response.setData(room);
        return ResponseEntity.status(HttpStatus.ACCEPTED).body(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<BaseResponse<Boolean>> deleteRoomById(@PathVariable Long id){
        BaseResponse<Boolean> response = new BaseResponse<>();
        if(id <= 0){
            response.setError("Id must be greater than 0");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        Boolean isDeleted = this.roomService.deleteRoom(id);
        if(!isDeleted){
            response.setData(false);
            response.setError("Delete room error");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        response.setData(true);
        return ResponseEntity.status(HttpStatus.ACCEPTED).body(response);
    }
}
