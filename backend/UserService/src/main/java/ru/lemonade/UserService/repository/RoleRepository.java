package ru.lemonade.UserService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.lemonade.UserService.model.Role;

import java.util.Optional;

public interface RoleRepository extends JpaRepository<Role, Long> {
    Optional<Role> getByTitle(String title);
}
