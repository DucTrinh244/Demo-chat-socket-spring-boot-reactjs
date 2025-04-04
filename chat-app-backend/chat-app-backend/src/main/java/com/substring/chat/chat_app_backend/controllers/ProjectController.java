package com.substring.chat.chat_app_backend.controllers;

import com.substring.chat.chat_app_backend.entities.Project;
import com.substring.chat.chat_app_backend.entities.Room;
import com.substring.chat.chat_app_backend.repositories.ProjectRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v2/projects")
@CrossOrigin("http://localhost:5173")

public class ProjectController {
    private ProjectRepository projectRepository;

    public ProjectController(ProjectRepository projectRepository) {
        this.projectRepository = projectRepository;
    }

    @PostMapping
    public ResponseEntity<?> crateRoom(@RequestBody String roomId){
        if(projectRepository.findByProjectId(roomId) != null){
            return ResponseEntity.badRequest().body("Project already exists");
        }
        Project project = new Project();
        project.setId(roomId);
        Project saveProject = projectRepository.save(project);
        return ResponseEntity.status(HttpStatus.CREATED).body(saveProject);
    }
    @GetMapping("/{projectId}")
    public ResponseEntity<?> getProject(@PathVariable String projectId){// chú ý pathvariable

        Project project =projectRepository.findByProjectId(projectId);

        if(project == null){
            return ResponseEntity.badRequest().body("Room not found");
        }
        return ResponseEntity.ok(project);// return room

    }


}
