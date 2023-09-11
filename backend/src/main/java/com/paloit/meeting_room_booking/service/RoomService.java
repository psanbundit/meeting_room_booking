package com.paloit.meeting_room_booking.service;

import com.paloit.meeting_room_booking.model.FormRoom;
import com.paloit.meeting_room_booking.model.Room;
import com.paloit.meeting_room_booking.repository.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RoomService {
    @Autowired
    private RoomRepository roomRepository;

    public List<Room> getAllRoom() {
        return this.roomRepository.findAll();
    }

    public Optional<Room> getById(Long id) {
        return this.roomRepository.findById(id);
    }

    public Room createRoom(Room room) {
        return this.roomRepository.save(room);
    }

    public Room updateRoom(Long id , FormRoom formRoom) {
        if(id <= 0) return null;
        Optional<Room> room = this.roomRepository.findById(id);
        if(room.isEmpty()){
            return null;
        }
        room.get().setName(formRoom.getName() == null || formRoom.getName().isBlank() ? room.get().getName() : formRoom.getName());
        room.get().setCapacity(formRoom.getCapacity() == null ? room.get().getCapacity() : formRoom.getCapacity());
        room.get().setActive(formRoom.getActive() == null ? room.get().getActive() : formRoom.getActive());
        this.roomRepository.save(room.get());
        return room.get();
    }

    public Boolean deleteRoom(Long id) {
        Optional<Room> room = this.roomRepository.findById(id);
        if(room.isEmpty()){
            return false;
        }
        this.roomRepository.deleteById(id);
        return true;
    }
}
