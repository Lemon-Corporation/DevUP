package ru.lemonade.gameservice.controller;

import org.springframework.web.bind.annotation.*;
import ru.lemonade.gameservice.interfaces.CompetitionsService;
import ru.lemonade.gameservice.model.CompetitionsModel;

import java.util.List;

@RestController
@RequestMapping("/api/v1/competitions")
public class CompetitionsController {
    private final CompetitionsService competitionsService;

    public CompetitionsController(CompetitionsService competitionsService) {
        this.competitionsService = competitionsService;
    }

    @GetMapping("/all")
    public List<CompetitionsModel> getAllCompetitions() {
        return competitionsService.getAllCompetitions();
    }

    @GetMapping("/active")
    public List<CompetitionsModel> getActiveCompetitions() {
        return competitionsService.getActiveCompetitions();
    }

    @GetMapping("/incoming")
    public List<CompetitionsModel> getIncomingCompetitions() {
        return competitionsService.getIncomingCompetitions();
    }

    @GetMapping("/ended")
    public List<CompetitionsModel> getEndedCompetitions() {
        return competitionsService.getEndedCompetitions();
    }

    @GetMapping("/user={user_id}")
    public List<CompetitionsModel> getUserCompetitions(@PathVariable String user_id) {
        return competitionsService.getUserCompetitions(user_id);
    }

    @PostMapping("/join/user={user_id}&competition={competition_id}")
    public String joinCompetition(@PathVariable String user_id, @PathVariable String competition_id) {
        CompetitionsModel res = competitionsService.joinCompetition(user_id, competition_id);
        if (res != null) {
            return "User " + user_id + " joined competition " + res.getCompName();
        }

        return "Error during joining competition";
    }

    @DeleteMapping("/leave/user={user_id}&competition={competition_id}")
    public String leaveCompetition(@PathVariable String user_id, @PathVariable String competition_id) {
        CompetitionsModel res = competitionsService.leaveCompetition(user_id, competition_id);
        if (res != null) {
            return "User " + user_id + " leaved competition " + res.getCompName();
        }

        return "Error during leaving competition";
    }
}
