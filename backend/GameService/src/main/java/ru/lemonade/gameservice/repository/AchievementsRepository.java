package ru.lemonade.gameservice.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.lemonade.gameservice.model.AchievementsModel;

public interface AchievementsRepository extends JpaRepository<AchievementsModel, Long> {
}
