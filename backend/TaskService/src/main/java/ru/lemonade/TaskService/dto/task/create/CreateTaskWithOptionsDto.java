package ru.lemonade.TaskService.dto.task.create;

import lombok.*;
import ru.lemonade.TaskService.pojo.Option;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateTaskWithOptionsDto extends CreateTaskDto {
    private boolean multiple;
    private List<Option> options;
}
