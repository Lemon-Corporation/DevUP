package ru.lemonade.TaskService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.lemonade.TaskService.model.answer.AlgorithmAnswer;
import ru.lemonade.TaskService.model.task.Task;

import java.util.Optional;
import java.util.UUID;

public interface AlgorithmAnswerRepository extends JpaRepository<AlgorithmAnswer, Long> {
    Optional<AlgorithmAnswer> findByTaskId(UUID taskId);
}
