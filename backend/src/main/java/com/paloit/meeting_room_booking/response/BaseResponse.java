package com.paloit.meeting_room_booking.response;

import org.springframework.validation.ObjectError;

public class BaseResponse<T> {
    private T data;
    private String error;

    public T getData() {
        return data;
    }

    public BaseResponse<T> setData(T data) {
        this.data = data;
        return this;
    }

    public String getErrors() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}
