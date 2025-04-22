package ru.lemonade.TaskService.dto.task;

import lombok.*;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TaskWithAlgorithmDto extends TaskDto {
    private String template;
}
