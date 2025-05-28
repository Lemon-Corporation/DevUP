package ru.lemonade.gameservice.controller;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.lemonade.gameservice.interfaces.services.LeaderboardService;

@RestController
@RequestMapping("/api/v1/leaderboard")
public class LeaderboardController {
    private final LeaderboardService leaderboardService;

    public LeaderboardController(LeaderboardService leaderboardService) {
        this.leaderboardService = leaderboardService;
    }

    @GetMapping("/direction/{directionId}")
    public String getLeaderboardByDirection(@PathVariable String directionId) {
        return leaderboardService.getLeaderboardListByDirection(Long.parseLong(directionId));
    }
}
