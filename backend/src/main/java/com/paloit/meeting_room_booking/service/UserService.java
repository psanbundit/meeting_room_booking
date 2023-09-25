package com.paloit.meeting_room_booking.service;

import com.paloit.meeting_room_booking.model.User;
import com.paloit.meeting_room_booking.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    public List<User> getAllUser() {
        return this.userRepository.findAll();
    }

    public Optional<User> getById(Long id) {
        return this.userRepository.findById(id);
    }

    public User createUser(User user) {
        return this.userRepository.save(user);
    }

    public User updateUser(Long id , User formUser) {
        if(id <= 0) return null;
        Optional<User> user = this.userRepository.findById(id);
        if(user.isEmpty()){
            return null;
        }
        user.get().setFirstName(formUser.getFirstName() == null || user.get().getFirstName().isBlank() ? user.get().getFirstName() : formUser.getFirstName());
        user.get().setLastName(formUser.getLastName() == null || user.get().getLastName().isBlank() ? user.get().getLastName() : formUser.getLastName());
        user.get().setEmail(formUser.getEmail() == null || user.get().getEmail().isBlank() ? user.get().getEmail() : formUser.getEmail());
        this.userRepository.save(user.get());
        return user.get();
    }

    public Boolean deleteUser(Long id) {
        Optional<User> user = this.userRepository.findById(id);
        if(user.isEmpty()){
            return false;
        }
        this.userRepository.deleteById(id);
        return true;
    }
}
