package com.substring.chat.chat_app_backend.controllers;

import com.substring.chat.chat_app_backend.entities.User;
import com.substring.chat.chat_app_backend.services.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {
    @Autowired
    private AuthService authService;

    @PostMapping("/register")
    public String register(@RequestBody User user) {
        return authService.register(user);
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password) {
        return authService.login(username, password) ? "Login successful!" : "Invalid credentials!";
    }
}