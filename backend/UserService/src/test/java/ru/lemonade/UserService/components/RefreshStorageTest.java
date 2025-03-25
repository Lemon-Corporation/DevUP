package ru.lemonade.UserService.components;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import ru.lemonade.UserService.security.util.RefreshStorage;

public class RefreshStorageTest {

    private RefreshStorage refreshStorage;

    @BeforeEach
    void setUp() {
        refreshStorage = new RefreshStorage();
    }

    @Test
    void testPutAndGet() {
        // Arrange: Сохраняем токен
        String username = "john@example.com";
        String refreshToken = "validRefreshToken";
        refreshStorage.put(username, refreshToken);

        // Act & Assert: Проверяем, что токен извлекается корректно
        String storedToken = refreshStorage.get(username);
        assertThat(storedToken).isEqualTo(refreshToken);
    }

    @Test
    void testBanToken() {
        // Arrange: Сохраняем токен
        String username = "john@example.com";
        String refreshToken = "validRefreshToken";
        refreshStorage.put(username, refreshToken);

        // Act: Баним токен
        refreshStorage.banToken(username);

        // Assert: Проверяем, что токен в черном списке
        boolean isInBlackList = !refreshStorage.isNotInBlackList(username);
        assertThat(isInBlackList).isTrue();
    }

    @Test
    void testIsNotInBlackList() {
        // Arrange: Сохраняем токен
        String username = "john@example.com";
        String refreshToken = "validRefreshToken";
        refreshStorage.put(username, refreshToken);

        // Act & Assert: Проверяем, что токен не в черном списке
        boolean isNotInBlackList = refreshStorage.isNotInBlackList(username);
        assertThat(isNotInBlackList).isTrue();
    }
}