package ru.lemonade.gameservice.controller;

import org.springframework.web.bind.annotation.*;
import ru.lemonade.gameservice.model.AchievementsModel;
import ru.lemonade.gameservice.interfaces.AchievementsService;
import ru.lemonade.gameservice.model.UserAchievementsModel;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/v1/achievements")
public class AchievementsController {
    private final AchievementsService achievementsService;

    public AchievementsController(AchievementsService achievementsService) {
        this.achievementsService = achievementsService;
    }

    @GetMapping("/user={user_id}")
    public List<Optional<AchievementsModel>> getUserAchievements(@PathVariable String user_id) {
        return achievementsService.getUserAchievements(user_id);
    }

    @PutMapping("/give_new_achievement/user={user_id}&achievement={achievement_id}")
    public String giveNewAchievementToUser(@PathVariable String user_id, @PathVariable String achievement_id) {
        return achievementsService.giveNewAchievementToUser(user_id, achievement_id);
    }

    @GetMapping("/all")
    public List<AchievementsModel> getAllAchievements() {
        return achievementsService.getAllAchievements();
    }
}
