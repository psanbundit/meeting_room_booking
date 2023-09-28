package com.paloit.meeting_room_booking.controller;



import com.paloit.meeting_room_booking.model.BookingStatus;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import com.paloit.meeting_room_booking.response.BaseResponse;
import com.paloit.meeting_room_booking.model.Booking;
import com.paloit.meeting_room_booking.model.FormBooking;
import com.paloit.meeting_room_booking.service.BookingService;

import jakarta.validation.Valid;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(value = "/booking")
public class BookingController {

    @Autowired
    private BookingService bookingService;

    @PostMapping("/{roomId}")
    public ResponseEntity<BaseResponse<Booking>> postBookingRoom(@PathVariable Long roomId, @ModelAttribute @Valid FormBooking formBooking, BindingResult bindingResult) {
        BaseResponse<Booking> response = new BaseResponse<>();

        if(bindingResult.hasErrors()){
            response.setError(bindingResult.getAllErrors().toString());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        // TODO: mocking user id
        Long userId = (long) 1;
        if (userId <= 0) {
            response.setError("User Id should be Long and greater than 0 ");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }else if (roomId <= 0) {
            response.setError("Room Id should be Long and greater than 0");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        Booking booking = this.bookingService.createBooking(userId, roomId, formBooking);
        if(booking == null){
            response.setError("Create booking error");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }
        response.setData(booking);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<Optional<Booking>>> getBooking(@PathVariable Long id) {
        BaseResponse<Optional<Booking>> response = new BaseResponse<>();

        if(id <= 0){
            response.setError("Booking Id should be Long and greater than 0");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }

        Optional<Booking> booking = this.bookingService.getById(id);
        if(booking.isEmpty()){
            response.setError("Booking not found");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }
        response.setData(booking);
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }

    @GetMapping("/my")
    public ResponseEntity<BaseResponse<List<Booking>>> getMyBooking(@RequestParam("status") BookingStatus status) {
//        TODO: Mocking user id
        Long userId = (long) 1;
        List<Booking> list = this.bookingService.getAllBookingByUserIdAndStatus(userId, status);
        BaseResponse<List<Booking>> response = new BaseResponse<>();
        if (userId <= 0) {
            response.setError("User Id should be Long and greater than 0 ");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        return ResponseEntity.status(HttpStatus.OK).body(response.setData(list));
    }

}
