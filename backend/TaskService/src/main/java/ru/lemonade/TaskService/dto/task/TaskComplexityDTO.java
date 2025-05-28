package ru.lemonade.TaskService.dto.task;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TaskComplexityDTO {
    private Long id;
    private String title;
    private Integer sortOrder;
} 