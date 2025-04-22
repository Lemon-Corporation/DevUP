package ru.lemonade.TaskService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.lemonade.TaskService.model.task.TaskType;

import java.util.Optional;

public interface TaskTypeRepository extends JpaRepository<TaskType, Long> {
    Optional<TaskType> findByTitle(String title);
}
