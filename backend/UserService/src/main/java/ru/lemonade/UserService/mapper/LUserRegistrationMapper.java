package ru.lemonade.UserService.mapper;

import ru.lemonade.UserService.dto.LUserRegistrationDto;
import ru.lemonade.UserService.model.LUser;

public class LUserRegistrationMapper {
    public static LUserRegistrationDto toDto(LUser user) {
        if (user == null) {
            return null;
        }
        LUserRegistrationDto dto = new LUserRegistrationDto();
        dto.setUsername(user.getUsername());
        dto.setPassword(user.getPassword());
        dto.setEmail(user.getEmail());
        return dto;
    }

    public static LUser toEntity(LUserRegistrationDto dto) {
        if (dto == null) {
            return null;
        }
        LUser user = new LUser();
        user.setUsername(dto.getUsername());
        user.setPassword(dto.getPassword());
        user.setEmail(dto.getEmail());
        return user;
    }
}
