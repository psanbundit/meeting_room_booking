package com.paloit.meeting_room_booking.repository;

import com.paloit.meeting_room_booking.dbmodel.Room;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RoomRepository extends JpaRepository<Room, Long> {

}
