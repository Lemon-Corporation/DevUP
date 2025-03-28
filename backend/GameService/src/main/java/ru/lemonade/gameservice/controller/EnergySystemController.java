package ru.lemonade.gameservice.controller;

import org.springframework.web.bind.annotation.*;
import ru.lemonade.gameservice.interfaces.EnergySystemService;
import ru.lemonade.gameservice.model.EnergySystemModel;

@RestController
@RequestMapping("/api/v1/energy")
public class EnergySystemController {
    private final EnergySystemService energySystemService;

    public EnergySystemController(EnergySystemService energySystemService) {
        this.energySystemService = energySystemService;
    }
    @GetMapping("/user={user_id}")
    public int getUserEnergyCount(@PathVariable String user_id) {
        return energySystemService.getUserEnergyCount(user_id);
    }

    @PostMapping("/add_energy/user={user_id}&amount={amount}")
    public EnergySystemModel addEnergyToUser(@PathVariable String user_id, @PathVariable String amount) {
        return energySystemService.addEnergyToUser(user_id, amount);
    }

    @PostMapping("/debit_energy/user={user_id}&amount={amount}")
    public EnergySystemModel debitEnergyUser(@PathVariable String user_id, @PathVariable String amount) {
        return energySystemService.debitEnergyUser(user_id, amount);
    }
}
