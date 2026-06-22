package com.akashmed.food_delivery.dtos;

import com.akashmed.food_delivery.validation.Lowercase;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class LoginUserRequest {

    @NotBlank(message = "email is required")
    @Email(message = "email must be valid")
    @Lowercase(message = "email must be lowercase")
    private String email;

    @NotBlank(message = "password is required")
    @Size(min = 6, max = 25, message = "password must be between 6 to 25 characters")
    private String password;
}
