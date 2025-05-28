package ru.lemonade.TaskService.mapper.TaskTag;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import ru.lemonade.TaskService.dto.tag.TaskTagDTO;
import ru.lemonade.TaskService.model.task.TaskTag;

@Mapper(componentModel = "spring")
public interface TaskTagMapper {

    TaskTagDTO toDTO(TaskTag taskTag);

    TaskTag toEntity(TaskTagDTO taskTagDTO);
} 