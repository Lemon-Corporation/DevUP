package ru.lemonade.UserService.mapper;

import ru.lemonade.UserService.dto.LUserProfilePublicDto;
import ru.lemonade.UserService.model.LUser;

public class LUserProfilePublicMapper {
    public static LUserProfilePublicDto toDto(LUser user) {
        if (user == null) {
            return null;
        }
        LUserProfilePublicDto dto = new LUserProfilePublicDto();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setEmail(user.getEmail());
        return dto;
    }

    public static LUser toEntity(LUserProfilePublicDto dto) {
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
