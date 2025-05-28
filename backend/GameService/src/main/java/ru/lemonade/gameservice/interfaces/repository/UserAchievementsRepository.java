package ru.lemonade.gameservice.interfaces.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.lemonade.gameservice.model.UserAchievementsModel;

import java.util.List;
import java.util.Optional;

public interface UserAchievementsRepository extends JpaRepository<UserAchievementsModel, Long> {
    List<UserAchievementsModel> findAllByUserId(Long userId);
    Optional<UserAchievementsModel> findAllByUserIdAndAchieveId(Long userId, Long achieveId);
}
