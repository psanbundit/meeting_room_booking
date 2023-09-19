package com.paloit.meeting_room_booking.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.paloit.meeting_room_booking.model.Booking;
import com.paloit.meeting_room_booking.model.User;
import com.paloit.meeting_room_booking.repository.BookingRepository;

@Service
public class BookingService {

    @Autowired
    private BookingRepository bookingRepository;

    public List<Booking> getAllBooking() {
        return this.bookingRepository.findAll();
    }

    public Optional<Booking> getById(Long id) {
        return this.bookingRepository.findById(id);
    }

    public Booking createBooking(Booking booking) {
        return this.bookingRepository.save(booking);
    }

    public Booking updateBooking(Long id, Booking formBooking) {
        if (id <= 0)
            return null;
        Optional<Booking> booking = this.bookingRepository.findById(id);
        if (booking.isEmpty()) {
            return null;
        }
        // booking1.get().setDate(formBooking.getDate() == null ?
        // booking1.get().getDate() : formBooking.getDate());
        booking.get().setStart(formBooking.getStart() == null ? booking.get().getStart() : formBooking.getStart());
        booking.get().setEnd(formBooking.getEnd() == null ? booking.get().getEnd() : formBooking.getEnd());
        booking.get().setRoom(formBooking.getRoom() == null ? booking.get().getRoom() : formBooking.getRoom());
        booking.get().setNbPeople(
                formBooking.getNbPeople() == null ? booking.get().getNbPeople() : formBooking.getNbPeople());
        booking.get().setUser(formBooking.getUser() == null ? booking.get().getUser() : formBooking.getUser());
        this.bookingRepository.save(booking.get());
        return booking.get();
    }

    public Boolean deleteBooking(Long id) {
        Optional<Booking> booking = this.bookingRepository.findById(id);
        if (booking.isEmpty()) {
            return false;
        }
        this.bookingRepository.deleteById(id);
        return true;
    }

}
