package ru.lemonade.TaskService.mapper.TaskComplexity;

import org.mapstruct.Mapper;
import ru.lemonade.TaskService.dto.task.TaskComplexityDTO;
import ru.lemonade.TaskService.model.task.TaskComplexity;

@Mapper(componentModel = "spring")
public interface TaskComplexityMapper {
    TaskComplexityDTO toDto(TaskComplexity taskComplexity);
    TaskComplexity toEntity(TaskComplexityDTO taskComplexityDTO);
} 