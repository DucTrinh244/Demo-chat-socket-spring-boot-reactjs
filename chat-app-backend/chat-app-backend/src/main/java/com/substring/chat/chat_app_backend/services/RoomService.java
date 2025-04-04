package com.substring.chat.chat_app_backend.services;

import com.substring.chat.chat_app_backend.entities.Room;
import com.substring.chat.chat_app_backend.repositories.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class RoomService {
    @Autowired
    private RoomRepository roomRepository;


}
