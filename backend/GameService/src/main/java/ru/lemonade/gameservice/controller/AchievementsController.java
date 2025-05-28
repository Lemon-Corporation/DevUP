package ru.lemonade.gameservice.controller;

import org.springframework.web.bind.annotation.*;
import ru.lemonade.gameservice.model.AchievementsModel;
import ru.lemonade.gameservice.interfaces.services.AchievementsService;
import ru.lemonade.gameservice.model.requests.ReceivingAchievementRequestModel;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/v1/achievements")
public class AchievementsController {
    private final AchievementsService achievementsService;

    public AchievementsController(AchievementsService achievementsService) {
        this.achievementsService = achievementsService;
    }

    @GetMapping("/user/{userId}")
    public List<Optional<AchievementsModel>> getUserAchievements(@PathVariable String userId) {
        return achievementsService.getUserAchievements(userId);
    }

    @PutMapping("/unlock")
    public String unlockAchievementToUser(@RequestBody ReceivingAchievementRequestModel requestModel) {
        return achievementsService.unlockAchievementToUser(requestModel.getUserId(), requestModel.getAchievementId());
    }
}
