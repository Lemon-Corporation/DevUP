package ru.lemonade.TaskService.mapper.TaskType;

import org.mapstruct.Mapper;
import ru.lemonade.TaskService.dto.type.TaskTypeDTO;
import ru.lemonade.TaskService.model.task.TaskType;

@Mapper(componentModel = "spring")
public interface TaskTypeMapper {
    TaskTypeDTO toDTO(TaskType taskType);
    TaskType toEntity(TaskTypeDTO taskTypeDTO);
}
