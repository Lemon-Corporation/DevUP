package ru.lemonade.TaskService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.lemonade.TaskService.model.task.TaskTag;

import java.util.List;
import java.util.Optional;

@Repository
public interface TaskTagRepository extends JpaRepository<TaskTag, Long> {
    Optional<TaskTag> findByTitle(String title);
    List<TaskTag> findByTitleContainingIgnoreCase(String title);
}
