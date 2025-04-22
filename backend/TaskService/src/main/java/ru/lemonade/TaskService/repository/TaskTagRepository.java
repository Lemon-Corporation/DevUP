package ru.lemonade.TaskService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.lemonade.TaskService.model.task.TaskTag;

import java.util.Optional;

public interface TaskTagRepository extends JpaRepository<TaskTag, Long> {
    Optional<TaskTag> findByTitle(String tagTitle);
}
