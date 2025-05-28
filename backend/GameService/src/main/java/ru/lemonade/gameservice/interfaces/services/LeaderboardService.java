package ru.lemonade.gameservice.interfaces.services;

import ru.lemonade.gameservice.model.LeaderboardModel;

import java.util.List;

public interface LeaderboardService {
    String getLeaderboardListByDirection(long direction);
}
