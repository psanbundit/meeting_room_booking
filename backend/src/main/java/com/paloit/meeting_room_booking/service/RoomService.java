package com.paloit.meeting_room_booking.service;

import com.paloit.meeting_room_booking.dbmodel.Room;
import com.paloit.meeting_room_booking.repository.RoomRepository;
import com.paloit.meeting_room_booking.request.RoomRequest;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class RoomService {

    private RoomRepository roomRepository;

    // constructor
    public RoomService(RoomRepository roomRepository) {
        this.roomRepository = roomRepository;
    }
//
    public List<Room> getRooms() {
        return roomRepository.findAll();
    }

    public Optional<Room> getRoomById(Long id) {
        return roomRepository.findById(id);
    }

    public Room createRoom(RoomRequest request) {
        Room newRoom = new Room();
        newRoom.setName(request.getName());
        newRoom.setCapacity(request.getCapacity());
        roomRepository.save(newRoom);

        return newRoom;
    }

    public void deleteRoom(Long id) {
        roomRepository.deleteById(id);
    }

    public Room updateRoom(Long id, RoomRequest request) {
        Optional<Room> room = getRoomById(id);


        room.get().setName(request.getName() != null ?  request.getName() : room.get().getName());

        room.get().setCapacity(request.getCapacity() != null ?  request.getCapacity() : room.get().getCapacity());

        roomRepository.save(room.get());

        System.out.println(room.get());

        return  room.get();
    }
}
