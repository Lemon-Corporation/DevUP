package ru.lemonade.gameservice.service;

import org.springframework.stereotype.Service;
import ru.lemonade.gameservice.interfaces.AchievementsService;
import ru.lemonade.gameservice.model.AchievementsModel;
import ru.lemonade.gameservice.model.UserAchievementsModel;
import ru.lemonade.gameservice.repository.AchievementsRepository;
import ru.lemonade.gameservice.repository.UserAchievementsRepository;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
    public List<Optional<AchievementsModel>> getUserAchievements(String user_id) {
        List<Optional<AchievementsModel>> achievementsModels = new ArrayList<>();
        List<UserAchievementsModel> userAchievementsModels = userAchievementsRepository.findAllByUserId(Long.parseLong(user_id));

        for (UserAchievementsModel userAchievementsModel : userAchievementsModels) {
            Optional<AchievementsModel> achievementsModel = achievementsRepository.findById(userAchievementsModel.getAchieveId());

            if (achievementsModel.isPresent()) {
                achievementsModels.add(achievementsModel);
            }
        }

        return achievementsModels;
    }

    @Override
    public String giveNewAchievementToUser(String userid, String achieve_id) {
        UserAchievementsModel newAchieve = new UserAchievementsModel();
        newAchieve.setUserId(Long.parseLong(userid));
        newAchieve.setAchieveId(Long.parseLong(achieve_id));
        newAchieve.setReceivedAt(LocalDateTime.now());

        Optional<UserAchievementsModel> model = userAchievementsRepository
                .findAllByUserIdAndAchieveId(Long.parseLong(userid), Long.parseLong(achieve_id));

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
