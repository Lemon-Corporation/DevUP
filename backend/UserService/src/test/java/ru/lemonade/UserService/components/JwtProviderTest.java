package ru.lemonade.UserService.components;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.SignatureAlgorithm;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import ru.lemonade.UserService.model.LUser;
import ru.lemonade.UserService.model.Role;
import ru.lemonade.UserService.security.LUserDetails;
import ru.lemonade.UserService.security.jwt.JwtProvider;

import javax.crypto.SecretKey;
import java.security.SecureRandom;
import java.time.Instant;
import java.util.Base64;
import java.util.Date;
import java.util.List;

public class JwtProviderTest {

    private JwtProvider jwtProvider;
    private SecretKey accessSecretKey;
    private SecretKey refreshSecretKey;

    @BeforeEach
    void setUp() {
        // Генерация уникальных ключей для каждого теста
        String accessSecret = generateBase64Key();
        String refreshSecret = generateBase64Key();

        // Создание JwtProvider с сгенерированными ключами
        jwtProvider = new JwtProvider(accessSecret, refreshSecret);

        // Декодирование ключей для использования в тестах
        accessSecretKey = Keys.hmacShaKeyFor(Base64.getDecoder().decode(accessSecret));
        refreshSecretKey = Keys.hmacShaKeyFor(Base64.getDecoder().decode(refreshSecret));
    }

    @Test
    void testGenerateAccessToken() {
        // Arrange: Создаем тестового пользователя
        LUserDetails userDetails = createTestUserDetails();

        // Act: Генерируем токен
        String accessToken = jwtProvider.generateAccessToken(userDetails);

        // Assert: Проверяем, что токен не пустой
        assertThat(accessToken).isNotEmpty();

        // Извлекаем данные из токена
        Claims claims = Jwts.parser()
                .setSigningKey(accessSecretKey)
                .build()
                .parseClaimsJws(accessToken)
                .getBody();
        assertThat(claims.getSubject()).isEqualTo("john@example.com");
        assertThat(claims.get("id", Long.class)).isEqualTo(1L);
        assertThat(claims.get("roles", List.class)).hasSize(1);
    }

    @Test
    void testValidateAccessToken_ValidToken() {
        // Arrange: Создаем тестовый токен
        LUserDetails userDetails = createTestUserDetails();
        String accessToken = jwtProvider.generateAccessToken(userDetails);

        // Act & Assert: Проверяем, что токен валиден
        assertTrue(jwtProvider.validateAccessToken(accessToken));
    }

    @Test
    void testValidateAccessToken_ExpiredToken() throws InterruptedException {
        // Arrange: Создаем тестовый токен с очень коротким сроком действия
        String expiredToken = Jwts.builder()
                .setSubject("john@example.com")
                .setExpiration(Date.from(Instant.now().minusSeconds(1))) // Истекший токен
                .signWith(accessSecretKey)
                .compact();

        // Act & Assert: Проверяем, что токен недействителен
        assertFalse(jwtProvider.validateAccessToken(expiredToken));
    }

    @Test
    void testGetAccessClaims() {
        // Arrange: Создаем тестовый токен
        LUserDetails userDetails = createTestUserDetails();
        String accessToken = jwtProvider.generateAccessToken(userDetails);

        // Act: Извлекаем данные из токена
        Claims claims = jwtProvider.getAccessClaims(accessToken);

        // Assert: Проверяем данные
        assertThat(claims.getSubject()).isEqualTo("john@example.com");
        assertThat(claims.get("id", Long.class)).isEqualTo(1L);
        assertThat(claims.get("roles", List.class)).hasSize(1);
    }


    private String generateBase64Key() {
        SecureRandom random = new SecureRandom();
        byte[] keyBytes = new byte[32]; // 32 байта = 256 бит
        random.nextBytes(keyBytes);
        return Base64.getEncoder().encodeToString(keyBytes);
    }

    private LUserDetails createTestUserDetails() {
        Role role = new Role();
        role.setId(1);
        role.setTitle("ROLE_USER");

        LUser user = new LUser();
        user.setId(1L);
        user.setUsername("john@example.com");
        user.setEmail("john@example.com");
        user.setPassword("encodedPassword");
        user.addRole(role);

        return new LUserDetails(user);
    }
}
