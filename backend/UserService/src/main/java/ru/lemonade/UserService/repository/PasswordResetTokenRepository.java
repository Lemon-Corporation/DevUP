package ru.lemonade.UserService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.lemonade.UserService.model.PasswordResetToken;

import java.util.Optional;

public interface PasswordResetTokenRepository extends JpaRepository<PasswordResetToken, Long> {
    Optional<PasswordResetToken> findByToken(String token);
    Optional<PasswordResetToken> findByUserId(Long userId);
}
