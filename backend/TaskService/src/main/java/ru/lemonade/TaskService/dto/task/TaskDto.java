package ru.lemonade.TaskService.dto.task;

import lombok.*;
import ru.lemonade.TaskService.dto.complexity.TaskComplexityDto;
import ru.lemonade.TaskService.dto.tag.TaskTagDto;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public abstract class TaskDto {
    private String title;
    private List<TaskTagDto> tags;
    private TaskComplexityDto complexity;
}
