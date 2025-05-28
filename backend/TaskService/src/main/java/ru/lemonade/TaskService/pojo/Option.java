package ru.lemonade.TaskService.pojo;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Option {
    @NonNull
    private String option;
    private boolean isCorrect;
}
