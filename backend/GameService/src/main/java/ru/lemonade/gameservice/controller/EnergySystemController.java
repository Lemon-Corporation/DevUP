package ru.lemonade.gameservice.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.lemonade.gameservice.interfaces.services.EnergySystemService;
import ru.lemonade.gameservice.model.requests.RestoreDebitEnergyRequestModel;


@RestController
@RequestMapping("/api/v1/energy")
public class EnergySystemController {
    private final EnergySystemService energySystemService;

    public EnergySystemController(EnergySystemService energySystemService) {
        this.energySystemService = energySystemService;
    }
    @GetMapping("/user/{userId}")
    public String getUserEnergyCount(@PathVariable String userId) {
        return energySystemService.getUserEnergyCount(userId);
    }

    @PostMapping("/user/{userId}/restore")
    public int addEnergyToUser(@PathVariable String userId, @RequestBody RestoreDebitEnergyRequestModel requestModel) {
        return energySystemService.addEnergyToUser(userId, requestModel.getAmount());
    }

    @PostMapping("/user/{userId}/consume")
    public ResponseEntity<String> debitEnergyUser(@PathVariable String userId, @RequestBody RestoreDebitEnergyRequestModel requestModel) {
        try {
            return new ResponseEntity<>(String.valueOf(energySystemService.debitEnergyUser(userId, requestModel.getAmount())), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.CONFLICT);
        }
    }
}
