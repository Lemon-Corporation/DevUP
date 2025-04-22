package ru.lemonade.TaskService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.lemonade.TaskService.model.answer.OptionsAnswer;
import ru.lemonade.TaskService.model.task.Task;

import java.util.Optional;
import java.util.UUID;

public interface OptionsAnswerRepository extends JpaRepository<OptionsAnswer, Long> {
    Optional<OptionsAnswer> findByTaskId(UUID taskId);
}
