package ru.lemonade.TaskService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.lemonade.TaskService.model.task.Task;

import java.util.Optional;
import java.util.UUID;

public interface TaskRepository extends JpaRepository<Task, UUID> {

}
