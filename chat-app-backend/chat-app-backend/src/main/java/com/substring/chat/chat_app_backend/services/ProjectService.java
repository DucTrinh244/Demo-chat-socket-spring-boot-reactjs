package com.substring.chat.chat_app_backend.services;

import com.substring.chat.chat_app_backend.repositories.ProjectRepository;
import com.substring.chat.chat_app_backend.repositories.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProjectService {
    @Autowired
    private ProjectRepository projectRepository;

}
