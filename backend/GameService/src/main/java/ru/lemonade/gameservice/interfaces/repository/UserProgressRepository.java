package ru.lemonade.gameservice.interfaces.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import ru.lemonade.gameservice.model.UserProgressModel;

public interface UserProgressRepository extends JpaRepository<UserProgressModel, Long> {
    UserProgressModel findFirstByUserId(Long userId);

    @Modifying
    @Query("update UserProgressModel model set model.points = model.points + :points WHERE model.id = :userId")
    UserProgressModel updateUserXp(Long userId, int points);

    @Modifying
    @Query("update UserProgressModel model set model.level = :level WHERE model.id = :userId")
    UserProgressModel updateUserLevel(Long userId, int level);
}
