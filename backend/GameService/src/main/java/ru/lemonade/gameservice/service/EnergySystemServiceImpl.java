package ru.lemonade.gameservice.service;

import org.springframework.stereotype.Service;
import ru.lemonade.gameservice.interfaces.services.EnergySystemService;
import ru.lemonade.gameservice.model.EnergySystemModel;
import ru.lemonade.gameservice.interfaces.repository.EnergySystemRepository;

@Service
public class EnergySystemServiceImpl implements EnergySystemService {
    private final EnergySystemRepository repository;

    public EnergySystemServiceImpl(EnergySystemRepository repository) {
        this.repository = repository;
    }
    @Override
    public String getUserEnergyCount(String userId) {
        EnergySystemModel esm = repository.findFirstByUserId(Long.parseLong(userId));

        return "{\"currentEnergy\":" + esm.getCurrentAmount() + ",\"maxEnergy\":" + esm.getMaxAmount() + "}";
    }

    @Override
    public int addEnergyToUser(String userId, int additionalEnergy) {
        EnergySystemModel model = repository.findFirstByUserId(Long.parseLong(userId));
        model.setCurrentAmount(
                Math.min((model.getCurrentAmount() + additionalEnergy), model.getMaxAmount())
        );
        return repository.save(model).getCurrentAmount();
    }

    @Override
    public int debitEnergyUser(String userId, int energySum) throws Exception {
        EnergySystemModel model = repository.findFirstByUserId(Long.parseLong(userId));

        if (model.getCurrentAmount() < energySum) {
            throw new Exception("Упс... Не хватает энергии для выполнения задания: " + (energySum - model.getCurrentAmount()));
        }

        model.setCurrentAmount(model.getCurrentAmount() - energySum);
        return repository.save(model).getCurrentAmount();
    }
}
