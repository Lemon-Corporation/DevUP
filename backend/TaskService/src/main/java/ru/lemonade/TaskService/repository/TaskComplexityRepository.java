package ru.lemonade.TaskService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.lemonade.TaskService.model.task.TaskComplexity;

import java.util.Optional;

public interface TaskComplexityRepository extends JpaRepository<TaskComplexity, Long> {
    Optional<TaskComplexity> findByTitle(String title);
}
