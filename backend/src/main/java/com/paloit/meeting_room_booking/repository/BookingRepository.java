package com.paloit.meeting_room_booking.repository;

import com.paloit.meeting_room_booking.model.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {

    // Custom query method to find bookings by user_id
    List<Booking> findByUserId(Long userId);

    List<Booking> findByUserIdAndStatus(Long userId, String status);
}
