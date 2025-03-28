package ru.lemonade.gameservice.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.lemonade.gameservice.model.CompetitionsModel;

import java.time.LocalDateTime;
import java.util.List;

public interface CompetitionRepository extends JpaRepository<CompetitionsModel, Long> {
    List<CompetitionsModel> findAllByAnnouncedAtBefore(LocalDateTime date);
    List<CompetitionsModel> findAllByStartAtBeforeAndEndAtAfter(LocalDateTime date1, LocalDateTime date2);
    List<CompetitionsModel> findAllByEndAtBefore(LocalDateTime date);
    List<CompetitionsModel> findAllByParticipantsIdsContaining(Long userId);
}
