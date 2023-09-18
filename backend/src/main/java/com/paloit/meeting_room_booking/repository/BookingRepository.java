package com.paloit.meeting_room_booking.repository;

import com.paloit.meeting_room_booking.dbmodel.Booking;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookingRepository extends CrudRepository<Booking, Long> {
}
