package ru.lemonade.TaskService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.lemonade.TaskService.model.answer.OptionsAnswer;
import ru.lemonade.TaskService.model.task.Task;

import java.util.Optional;
import java.util.UUID;
@Repository
public interface OptionsAnswerRepository extends JpaRepository<OptionsAnswer, Long> {
    Optional<OptionsAnswer> findByTaskId(UUID taskId);
}
