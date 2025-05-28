package ru.lemonade.gameservice.interfaces.services;

import ru.lemonade.gameservice.model.EnergySystemModel;

public interface EnergySystemService {
    String getUserEnergyCount(String userId);
    int addEnergyToUser(String userId, int amount);
    int debitEnergyUser(String userId, int amount) throws Exception;
}
