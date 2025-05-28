package ru.lemonade.gameservice.interfaces.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.lemonade.gameservice.model.LevelGraduateModel;

public interface LevelGraduateRepository extends JpaRepository<LevelGraduateModel, Integer> {
    LevelGraduateModel getFirstByStartPointLessThanAndEndPointGreaterThanEqual(Integer point1, Integer point2);
}
