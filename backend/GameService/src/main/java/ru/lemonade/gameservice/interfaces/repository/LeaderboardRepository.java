package ru.lemonade.gameservice.interfaces.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import ru.lemonade.gameservice.model.LeaderboardModel;

import java.util.List;

public interface LeaderboardRepository extends JpaRepository<LeaderboardModel, Long> {
    List<LeaderboardModel> getLeaderboardModelsByDirectionOrderByPointsDesc(Long direction);

    @Modifying
    @Query("update LeaderboardModel model set model.userPosition = :position WHERE model.id = :id")
    LeaderboardModel updateUserPosition(Long id, int position);
}
