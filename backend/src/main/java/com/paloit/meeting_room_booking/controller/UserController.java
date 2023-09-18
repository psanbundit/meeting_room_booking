package com.paloit.meeting_room_booking.controller;

import com.paloit.meeting_room_booking.model.User;
import com.paloit.meeting_room_booking.response.BaseResponse;
import com.paloit.meeting_room_booking.service.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(value = "/user")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("")
    public ResponseEntity<BaseResponse<List<User>>> getAllUser(){
        List<User> list = this.userService.getAllUser();
        BaseResponse<List<User>> response = new BaseResponse<>();
        return  ResponseEntity.status(HttpStatus.OK).body(response.setData(list));
    }

//    TODO: Update get user to only get public info
    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<Optional<User>>> getUserById(@PathVariable Long id){
        Optional<User> user = this.userService.getById(id);
        BaseResponse<Optional<User>> response = new BaseResponse<>();
        if(user.isEmpty()){
            response.setError("User not found");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }
        response.setData(user);
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }

//    TODO: Update response user to only get public info
    @PostMapping("")
    public ResponseEntity<BaseResponse<User>> postCreateUser(@ModelAttribute @Valid User formUser, BindingResult bindingResult){
        BaseResponse<User> response = new BaseResponse<>();
        if(bindingResult.hasErrors()){
            response.setError("Binding error");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        User user = this.userService.createUser(formUser);
        if(user == null){
            response.setError("Create user error");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }
        response.setData(user);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

//    TODO: Update response user to only get public info
    @PutMapping("/{id}")
    public ResponseEntity<BaseResponse<User>> updateRoomById(@PathVariable Long id, @ModelAttribute @Valid User formUser, BindingResult bindingResult){
        BaseResponse<User> response = new BaseResponse<>();
        if(id <= 0){
            response.setError("Id must be greater than 0");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        if(bindingResult.hasErrors()){
            response.setError("Binding error");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        User user = this.userService.updateUser(id, formUser);
        if(user == null){
            response.setError("Update user error");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }
        response.setData(user);
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<BaseResponse<Boolean>> deleteRoomById(@PathVariable Long id){
        BaseResponse<Boolean> response = new BaseResponse<>();
        if(id <= 0){
            response.setError("Id must be greater than 0");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        Boolean isDeleted = this.userService.deleteUser(id);
        if(isDeleted){
            response.setData(false);
            response.setError("Delete user error");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        response.setData(true);
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }
}
