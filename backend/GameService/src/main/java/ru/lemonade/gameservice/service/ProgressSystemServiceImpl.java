package ru.lemonade.gameservice.service;

import org.springframework.stereotype.Service;
import ru.lemonade.gameservice.interfaces.services.ProgressSystemService;
import ru.lemonade.gameservice.model.LevelGraduateModel;
import ru.lemonade.gameservice.model.UserProgressModel;
import ru.lemonade.gameservice.interfaces.repository.LevelGraduateRepository;
import ru.lemonade.gameservice.interfaces.repository.UserProgressRepository;

@Service
public class ProgressSystemServiceImpl implements ProgressSystemService {
    private final UserProgressRepository userProgressRepository;
    private final LevelGraduateRepository levelGraduateRepository;

    public ProgressSystemServiceImpl(UserProgressRepository userProgressRepository, LevelGraduateRepository levelGraduateRepository) {
        this.userProgressRepository = userProgressRepository;
        this.levelGraduateRepository = levelGraduateRepository;
    }

    @Override
    public String getProgress(String userId) {
        UserProgressModel model = userProgressRepository.findFirstByUserId(Long.parseLong(userId));

        return "{\"level\": " + model.getLevel() + ",\"xp\": " + model.getPoints() + "}";
    }

    @Override
    public String updateXp(String userId, int points) {
        UserProgressModel updatedXpModel = userProgressRepository.updateUserXp(Long.parseLong(userId), points);
        LevelGraduateModel model = levelGraduateRepository
                .getFirstByStartPointLessThanAndEndPointGreaterThanEqual(
                        updatedXpModel.getPoints(),
                        updatedXpModel.getPoints()
                );

        UserProgressModel updatedLevelModel = userProgressRepository.updateUserLevel(Long.parseLong(userId), model.getLevel());

        return "{\"updatedPoints\": " + updatedXpModel.getPoints() + ",\"level\": " + updatedLevelModel.getLevel() + "}";
    }
}
