package ru.lemonade.UserService.mapper;

import ru.lemonade.UserService.dto.LUserDefaultDto;
import ru.lemonade.UserService.model.LUser;

public class LUserDefaultMapper {
    public static LUserDefaultDto toDto(LUser user) {
        if (user == null) {
            return null;
        }
        LUserDefaultDto dto = new LUserDefaultDto();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setEmail(user.getEmail());
        return dto;
    }

    public static LUser toEntity(LUserDefaultDto dto) {
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
