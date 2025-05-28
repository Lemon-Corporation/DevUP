package ru.lemonade.TaskService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.lemonade.TaskService.model.task.TaskComplexity;

import java.util.List;
import java.util.Optional;

@Repository
public interface TaskComplexityRepository extends JpaRepository<TaskComplexity, Long> {
    Optional<TaskComplexity> findByTitle(String title);
    List<TaskComplexity> findByTitleContainingIgnoreCase(String title);
}
