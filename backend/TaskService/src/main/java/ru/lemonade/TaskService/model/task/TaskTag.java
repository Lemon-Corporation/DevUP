package ru.lemonade.TaskService.model.task;

import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "tags")
@Data
public class TaskTag {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @Column(unique = true, nullable = false)
    private String title;
    
    @ManyToMany(mappedBy = "tags")
    private Set<Task> tasks;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TaskTag taskTag = (TaskTag) o;
        return id == taskTag.id && Objects.equals(title, taskTag.title);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, title);
    }
}
