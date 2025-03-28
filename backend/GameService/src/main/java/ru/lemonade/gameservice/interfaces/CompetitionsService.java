package ru.lemonade.gameservice.interfaces;

import ru.lemonade.gameservice.model.CompetitionsModel;

import java.util.List;

public interface CompetitionsService {
    List<CompetitionsModel> getAllCompetitions();
    List<CompetitionsModel> getActiveCompetitions();
    List<CompetitionsModel> getEndedCompetitions();
    List<CompetitionsModel> getIncomingCompetitions();
    List<CompetitionsModel> getUserCompetitions(String userId);
    CompetitionsModel joinCompetition(String userId, String competitionId);
    CompetitionsModel leaveCompetition(String userId, String competitionId);
}
