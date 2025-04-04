package com.substring.chat.chat_app_backend.controllers;


import com.substring.chat.chat_app_backend.entities.Message;
import com.substring.chat.chat_app_backend.entities.Room;
import com.substring.chat.chat_app_backend.repositories.RoomRepository;
import com.substring.chat.chat_app_backend.services.RoomService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/rooms")
@CrossOrigin("http://localhost:5173")
public class RoomController {
    private RoomRepository roomRepository;

    public RoomController(RoomRepository roomRepository) {
        this.roomRepository = roomRepository;
    }

    // create room
    @PostMapping
    public ResponseEntity<?> crateRoom(@RequestBody String roomId){
        if(roomRepository.findByRoomId(roomId) != null){

            // rooom adready create there
            return ResponseEntity.badRequest().body("Room already exists");

        }
        // create room
        Room room = new Room();
        room.setRoomId(roomId);
        Room savedRoom = roomRepository.save(room);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedRoom);


    }


    // join rooms

    @GetMapping("/{roomId}")
    public ResponseEntity<?> joinRooms(@PathVariable String roomId){// chú ý pathvariable

        Room room =roomRepository.findByRoomId(roomId);

        if(room == null){
            return ResponseEntity.badRequest().body("Room not found");
        }
        return ResponseEntity.ok(room);// return room

    }



    // get message of room
    @GetMapping("/{roomId}/messages")
    public ResponseEntity<List<Message>> getMessages(
            @PathVariable String roomId,
            @RequestParam(value = "page", defaultValue = "0",required = false) int page,
            @RequestParam(value = "size", defaultValue = "20",required = false) int size
    ){
       Room room= roomRepository.findByRoomId(roomId);
       if(room == null){
           return ResponseEntity.badRequest().build();
       }

       // get messages
       List<Message> messages = room.getMessages();
            int start = Math.max(0, messages.size() - (page + 1) * size);
            int end = Math.min( messages.size() ,start + size);
       List<Message>  paginatedMessages= messages.subList(start, end);
       return ResponseEntity.ok(paginatedMessages);

    }


}
