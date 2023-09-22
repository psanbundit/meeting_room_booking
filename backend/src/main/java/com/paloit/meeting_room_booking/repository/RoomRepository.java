package com.paloit.meeting_room_booking.repository;

import com.paloit.meeting_room_booking.model.Room;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface RoomRepository extends JpaRepository<Room, Long> {

    @Query("SELECT r FROM Room r " +
            "WHERE NOT EXISTS (SELECT b FROM Booking b " +
            "                  WHERE b.room = r " +
            "                  AND :endTime > b.start AND :startTime < b.end)")
    List<Room> findAvailableRoomsInPeriod(
            @Param("startTime") LocalDateTime startTime,
            @Param("endTime") LocalDateTime endTime);
}
