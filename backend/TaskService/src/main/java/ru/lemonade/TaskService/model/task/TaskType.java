package ru.lemonade.TaskService.model.task;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "task_types")
@Data
public class TaskType {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private long id;
    @Column(unique = true, nullable = false)
    private String title;
}
