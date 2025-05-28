package ru.lemonade.TaskService.dto.type;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TaskTypeDTO {
    private Long id;
    private String title;
}
