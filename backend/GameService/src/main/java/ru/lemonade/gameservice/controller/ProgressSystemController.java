package ru.lemonade.gameservice.controller;

import org.springframework.web.bind.annotation.*;
import ru.lemonade.gameservice.interfaces.services.ProgressSystemService;
import ru.lemonade.gameservice.model.requests.UpdateXpRequestModel;

@RestController
@RequestMapping("/api/v1/game")
public class ProgressSystemController {
    private final ProgressSystemService progressSystemService;

    public ProgressSystemController(ProgressSystemService progressSystemService) {
        this.progressSystemService = progressSystemService;
    }

    @GetMapping("/user/{userId}/progress")
    public String getProgress(@PathVariable String userId) {
        return progressSystemService.getProgress(userId);
    }

    @PostMapping("/user/{userId}/update_xp")
    public String updateXp(@PathVariable String userId, @RequestBody UpdateXpRequestModel requestModel) {
        return progressSystemService.updateXp(userId, requestModel.getXp());
    }
}
