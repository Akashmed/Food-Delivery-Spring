package com.akashmed.food_delivery.controllers;

import com.akashmed.food_delivery.dtos.RegisterUserRequest;
import com.akashmed.food_delivery.entities.Role;
import com.akashmed.food_delivery.mappers.UserMapper;
import com.akashmed.food_delivery.repositories.UserRepository;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.Map;

@AllArgsConstructor
@RestController
@RequestMapping("/users")
public class UserController {
    private final UserRepository userRepository;
    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;

    @PostMapping
    public ResponseEntity<?> registerUser(
          @Valid @RequestBody RegisterUserRequest request,
          UriComponentsBuilder uriBuilder
            )
    {
        if(userRepository.existsByEmail(request.getEmail())){
            return ResponseEntity.badRequest().body(
                    Map.of("email", "Email is already registered")
            );
        }

        var user = userMapper.toEntity(request);
        user.setRole(Role.CUSTOMER);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);

        var userDto = userMapper.toDto(user);
        var uri = uriBuilder.path("/users/{id}").buildAndExpand(userDto.getId()).toUri();

        return ResponseEntity.created(uri).body(userDto);

    }
}
