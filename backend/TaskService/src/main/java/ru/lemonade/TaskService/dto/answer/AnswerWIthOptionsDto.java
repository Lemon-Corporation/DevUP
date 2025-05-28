package ru.lemonade.TaskService.dto.answer;

import lombok.*;
import ru.lemonade.TaskService.pojo.Option;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AnswerWIthOptionsDto {
    private boolean multiple;
    private List<Option> options;
}
