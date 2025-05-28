package ru.lemonade.TaskService.dto.task.create;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@JsonTypeInfo(use = JsonTypeInfo.Id.NAME, property = "type")
@JsonSubTypes({
        @JsonSubTypes.Type(value = CreateTaskWithOptionsDto.class, name = "OPTIONS")
})

public class CreateTaskDto {
    private String title;
    private String description;
    private List<Long> tagIds;
    private long typeID;
    private long complexityId;
}
