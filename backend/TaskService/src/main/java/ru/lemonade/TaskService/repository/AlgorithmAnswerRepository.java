package ru.lemonade.TaskService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.lemonade.TaskService.model.answer.AlgorithmAnswer;

import java.util.Optional;
import java.util.UUID;
@Repository
public interface AlgorithmAnswerRepository extends JpaRepository<AlgorithmAnswer, Long> {
    Optional<AlgorithmAnswer> findByTaskId(UUID taskId);
}
