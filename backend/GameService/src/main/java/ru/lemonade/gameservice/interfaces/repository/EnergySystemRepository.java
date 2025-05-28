package ru.lemonade.gameservice.interfaces.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.lemonade.gameservice.model.EnergySystemModel;

public interface EnergySystemRepository extends JpaRepository<EnergySystemModel, Long> {
    EnergySystemModel findFirstByUserId(Long userId);
}
