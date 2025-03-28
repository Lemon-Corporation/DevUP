package ru.lemonade.gameservice.service;

import org.springframework.stereotype.Service;
import ru.lemonade.gameservice.interfaces.EnergySystemService;
import ru.lemonade.gameservice.model.EnergySystemModel;
import ru.lemonade.gameservice.repository.EnergySystemRepository;

@Service
public class EnergySystemServiceImpl implements EnergySystemService {
    private final EnergySystemRepository repository;

    public EnergySystemServiceImpl(EnergySystemRepository repository) {
        this.repository = repository;
    }
    @Override
    public int getUserEnergyCount(String user_id) {
        return repository.findFirstByUserId(Long.parseLong(user_id)).getCurrentAmount();
    }

    @Override
    public EnergySystemModel addEnergyToUser(String user_id, String additional_energy) {
        EnergySystemModel model = repository.findFirstByUserId(Long.parseLong(user_id));
        model.setCurrentAmount(
                Math.min((model.getCurrentAmount() + Integer.parseInt(additional_energy)), model.getMaxAmount())
        );
        return repository.save(model);
    }

    @Override
    public EnergySystemModel debitEnergyUser(String user_id, String energy_sum) {
        EnergySystemModel model = repository.findFirstByUserId(Long.parseLong(user_id));
        model.setCurrentAmount(Math.max(model.getCurrentAmount() - Integer.parseInt(energy_sum), 0));
        return repository.save(model);
    }
}
