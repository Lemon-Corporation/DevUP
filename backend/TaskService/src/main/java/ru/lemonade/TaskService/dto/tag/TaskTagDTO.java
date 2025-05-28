package ru.lemonade.TaskService.dto.tag;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TaskTagDTO {
    private Long id;
    
    @NotBlank(message = "Title is required")
    private String title;
} 