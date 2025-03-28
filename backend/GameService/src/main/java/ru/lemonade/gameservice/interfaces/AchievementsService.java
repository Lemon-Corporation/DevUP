package ru.lemonade.gameservice.interfaces;

import org.springframework.web.bind.annotation.RequestBody;
import ru.lemonade.gameservice.model.AchievementsModel;
import ru.lemonade.gameservice.model.UserAchievementsModel;

import java.util.List;
import java.util.Optional;

public interface AchievementsService {
    List<Optional<AchievementsModel>> getUserAchievements(String user_id);
    String giveNewAchievementToUser(String user_id, String achieve_id);
    List<AchievementsModel> getAllAchievements();
    AchievementsModel createAchievement(AchievementsModel model);
}
