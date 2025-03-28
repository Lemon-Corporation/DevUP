package ru.lemonade.gameservice.service;

import org.springframework.stereotype.Service;
import ru.lemonade.gameservice.interfaces.CompetitionsService;
import ru.lemonade.gameservice.model.CompetitionsModel;
import ru.lemonade.gameservice.repository.CompetitionRepository;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Service
public class CompetitionsServiceImpl implements CompetitionsService {
    private final CompetitionRepository competitionRepository;

    public CompetitionsServiceImpl(CompetitionRepository competitionRepository) {
        this.competitionRepository = competitionRepository;
    }
    @Override
    public List<CompetitionsModel> getAllCompetitions() {
        return competitionRepository.findAll();
    }

    @Override
    public List<CompetitionsModel> getActiveCompetitions() {
        LocalDateTime date = LocalDateTime.now();
        return competitionRepository.findAllByStartAtBeforeAndEndAtAfter(date, date);
    }

    @Override
    public List<CompetitionsModel> getEndedCompetitions() {
        return competitionRepository.findAllByEndAtBefore(LocalDateTime.now());
    }

    @Override
    public List<CompetitionsModel> getIncomingCompetitions() {
        return competitionRepository.findAllByAnnouncedAtBefore(LocalDateTime.now());
    }

    @Override
    public List<CompetitionsModel> getUserCompetitions(String user_id) {
        return competitionRepository.findAllByParticipantsIdsContaining(Long.parseLong(user_id));
    }

    @Override
    public CompetitionsModel joinCompetition(String user_id, String competition_id) {
        Optional<CompetitionsModel> competition = competitionRepository.findById(Long.parseLong(competition_id));
        if (competition.isPresent()) {
            List<Long> list = new ArrayList<>();

            for (int i = 0; i < competition.get().getParticipantsIds().length; ++i) {
                if (competition.get().getParticipantsIds()[i] != Long.parseLong(user_id)) {
                    return null;
                }
                list.add(competition.get().getParticipantsIds()[i]);
            }

            list.add(Long.parseLong(user_id));

            competition.get().setParticipantsIds(list);

            return competitionRepository.save(competition.get());
        }

        return null;
    }

    @Override
    public CompetitionsModel leaveCompetition(String user_id, String competition_id) {
        Optional<CompetitionsModel> competition = competitionRepository.findById(Long.parseLong(competition_id));

        if (competition.isPresent()) {
            List<Long> list = new ArrayList<>();

            for (int i = 0; i < competition.get().getParticipantsIds().length; ++i) {
                if (competition.get().getParticipantsIds()[i] == Long.parseLong(user_id)) {
                    continue;
                }
                list.add(competition.get().getParticipantsIds()[i]);
            }

            competition.get().setParticipantsIds(list);

            return competitionRepository.save(competition.get());
        }

        return null;
    }
}
