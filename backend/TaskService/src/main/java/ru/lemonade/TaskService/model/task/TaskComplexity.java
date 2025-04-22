package ru.lemonade.TaskService.model.task;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "task_complexities")
@Data
public class TaskComplexity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @Column(unique = true, nullable = false)
    private String title;
    private int sortOrder;
}
