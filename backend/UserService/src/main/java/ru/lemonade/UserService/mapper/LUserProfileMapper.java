package ru.lemonade.UserService.mapper;

import ru.lemonade.UserService.dto.LUserProfileDto;
import ru.lemonade.UserService.model.LUser;

public class LUserProfileMapper {
    public static LUserProfileDto toDto(LUser user) {
        if (user == null) {
            return null;
        }
        LUserProfileDto dto = new LUserProfileDto();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setEmail(user.getEmail());
        return dto;
    }

    public static LUser toEntity(LUserProfileDto dto) {
        if (dto == null) {
            return null;
        }
        LUser user = new LUser();
        user.setId(dto.getId());
        user.setUsername(dto.getUsername());
        user.setEmail(dto.getEmail());
        return user;
    }
}
