package ru.lemonade.TaskService.dto.task;

import lombok.*;
import ru.lemonade.TaskService.pojo.Option;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TaskWithOptionsDto extends TaskDto {
    private boolean multiple;
    private List<Option> options;
}
