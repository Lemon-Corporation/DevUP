package ru.lemonade.gameservice.interfaces.services;

import org.springframework.web.bind.annotation.RequestBody;
import ru.lemonade.gameservice.model.AchievementsModel;
import ru.lemonade.gameservice.model.UserAchievementsModel;

import java.util.List;
import java.util.Optional;

public interface AchievementsService {
    List<Optional<AchievementsModel>> getUserAchievements(String userId);
    String unlockAchievementToUser(String userId, String achieveId);
    List<AchievementsModel> getAllAchievements();
    AchievementsModel createAchievement(AchievementsModel model);
}
