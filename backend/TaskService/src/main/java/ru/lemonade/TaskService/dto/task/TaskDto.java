package ru.lemonade.TaskService.dto.task;

import lombok.*;
import ru.lemonade.TaskService.dto.complexity.TaskComplexityDTO;
import ru.lemonade.TaskService.dto.tag.TaskTagDTO;
import ru.lemonade.TaskService.dto.type.TaskTypeDTO;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TaskDto {
    private UUID id;
    private String title;
    private String description;
    private List<TaskTagDTO> tags;
    private TaskTypeDTO type;
    private TaskComplexityDTO complexity;
}
