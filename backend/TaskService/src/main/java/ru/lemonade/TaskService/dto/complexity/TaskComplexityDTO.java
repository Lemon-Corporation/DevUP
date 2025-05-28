package ru.lemonade.TaskService.dto.complexity;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TaskComplexityDTO {
    private Long id;
    
    @NotBlank(message = "Title is required")
    private String title;
    
    @Min(value = 0, message = "Sort order must be greater than or equal to 0")
    private int sortOrder;
} 