package com.substring.chat.chat_app_backend.repositories;

import com.substring.chat.chat_app_backend.entities.Project;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ProjectRepository extends MongoRepository<Project,String> {
    // get room by id
    Project findByProjectId(String projectId);

}
