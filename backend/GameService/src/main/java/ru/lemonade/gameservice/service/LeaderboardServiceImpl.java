package ru.lemonade.gameservice.service;

import org.springframework.stereotype.Service;
import ru.lemonade.gameservice.interfaces.repository.LeaderboardRepository;
import ru.lemonade.gameservice.interfaces.services.LeaderboardService;
import ru.lemonade.gameservice.model.LeaderboardModel;

import java.util.List;


@Service
public class LeaderboardServiceImpl implements LeaderboardService {
    private final LeaderboardRepository repository;

    public LeaderboardServiceImpl(LeaderboardRepository repository) {
        this.repository = repository;
    }

    @Override
    public String getLeaderboardListByDirection(long direction) {
        StringBuilder answerInJson = new StringBuilder();

        List<LeaderboardModel> leaderboard = repository.getLeaderboardModelsByDirectionOrderByPointsDesc(direction);

        for (int i = 0; i < leaderboard.size(); ++i) {
            LeaderboardModel currentModel = leaderboard.get(i);

            LeaderboardModel updatedModel = repository.updateUserPosition(currentModel.getId(), i + 1);
            answerInJson
                    .append("{")
                    .append("\"userId\": ").append(updatedModel.getUserId())
                    .append(", \"direction\": ").append(updatedModel.getDirection())
                    .append(", \"position\": ").append(updatedModel.getUserPosition())
                    .append(", \"points\": ").append(updatedModel.getPoints())
                    .append("}");

            if (i + 1 != leaderboard.size()) {
                answerInJson.append(",");
            }
        }

        return "[" + answerInJson + "]";
    }
}
