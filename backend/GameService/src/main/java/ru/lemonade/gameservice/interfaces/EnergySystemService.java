package ru.lemonade.gameservice.interfaces;

import ru.lemonade.gameservice.model.EnergySystemModel;

public interface EnergySystemService {
    int getUserEnergyCount(String user_id);
    EnergySystemModel addEnergyToUser(String user_id, String amount);
    EnergySystemModel debitEnergyUser(String user_id, String amount);
}
