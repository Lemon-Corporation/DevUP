package ru.lemonade.TaskService.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.lemonade.TaskService.model.task.TaskType;

import java.util.Optional;

@Repository
public interface TaskTypeRepository extends JpaRepository<TaskType, Long> {
    Optional<TaskType> findByTitle(String title);
    Page<TaskType> findByTitleContainingIgnoreCase(String title, Pageable pageable);
}
