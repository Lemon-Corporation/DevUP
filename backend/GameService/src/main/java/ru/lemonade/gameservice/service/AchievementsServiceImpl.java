package ru.lemonade.gameservice.service;

import org.springframework.stereotype.Service;
import ru.lemonade.gameservice.interfaces.services.AchievementsService;
import ru.lemonade.gameservice.model.AchievementsModel;
import ru.lemonade.gameservice.model.UserAchievementsModel;
import ru.lemonade.gameservice.interfaces.repository.AchievementsRepository;
import ru.lemonade.gameservice.interfaces.repository.UserAchievementsRepository;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class AchievementsServiceImpl implements AchievementsService {
    private final AchievementsRepository achievementsRepository;
    private final UserAchievementsRepository userAchievementsRepository;

    public AchievementsServiceImpl(AchievementsRepository achievementsRepository, UserAchievementsRepository userAchievementsRepository) {
        this.achievementsRepository = achievementsRepository;
        this.userAchievementsRepository = userAchievementsRepository;
    }

    @Override
    public List<Optional<AchievementsModel>> getUserAchievements(String userId) {
        List<Optional<AchievementsModel>> achievementsModels = new ArrayList<>();
        List<UserAchievementsModel> userAchievementsModels = userAchievementsRepository.findAllByUserId(Long.parseLong(userId));

        for (UserAchievementsModel userAchievementsModel : userAchievementsModels) {
            Optional<AchievementsModel> achievementsModel = achievementsRepository.findById(userAchievementsModel.getAchieveId());

            if (achievementsModel.isPresent()) {
                achievementsModels.add(achievementsModel);
            }
        }

        return achievementsModels;
    }

    @Override
    public String unlockAchievementToUser(String userid, String achieveId) {
        UserAchievementsModel newAchieve = new UserAchievementsModel();
        newAchieve.setUserId(Long.parseLong(userid));
        newAchieve.setAchieveId(Long.parseLong(achieveId));
        newAchieve.setReceivedAt(LocalDateTime.now());

        Optional<UserAchievementsModel> model = userAchievementsRepository
                .findAllByUserIdAndAchieveId(Long.parseLong(userid), Long.parseLong(achieveId));

        return model.map(
                    userAchievementsModel -> "Achievement " + userAchievementsModel.getAchieveId() + " already received"
                )
                .orElseGet(() -> "Achievement " + userAchievementsRepository.save(newAchieve).getAchieveId() + " received right now"
                );
    }

    @Override
    public List<AchievementsModel> getAllAchievements() {
        return achievementsRepository.findAll();
    }

    @Override
    public AchievementsModel createAchievement(AchievementsModel model) {
        return achievementsRepository.save(model);
    }
}
