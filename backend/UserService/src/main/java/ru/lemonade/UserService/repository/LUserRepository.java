package ru.lemonade.UserService.repository;
;
import org.springframework.data.jpa.repository.JpaRepository;
import ru.lemonade.UserService.model.LUser;

import java.util.Optional;

public interface LUserRepository extends JpaRepository<LUser, Long> {
    Optional<LUser> findByEmail(String name);
    Optional<LUser> findByUsername(String username);
}
