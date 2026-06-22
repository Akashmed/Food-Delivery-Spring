package com.akashmed.food_delivery.mappers;

import com.akashmed.food_delivery.dtos.LoginUserRequest;
import com.akashmed.food_delivery.dtos.RegisterUserRequest;
import com.akashmed.food_delivery.dtos.UserDto;
import com.akashmed.food_delivery.entities.User;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface UserMapper {

    UserDto toDto (User user);
    User toEntity (RegisterUserRequest registerUserRequest);
}
