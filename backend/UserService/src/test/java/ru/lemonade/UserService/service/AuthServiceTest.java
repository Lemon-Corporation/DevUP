package ru.lemonade.UserService.service;

import static org.mockito.Mockito.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

import io.jsonwebtoken.Claims;
import jakarta.security.auth.message.AuthException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.crypto.password.PasswordEncoder;
import ru.lemonade.UserService.error.exception.InvalidTokenException;
import ru.lemonade.UserService.model.LUser;
import ru.lemonade.UserService.model.Role;
import ru.lemonade.UserService.request.AuthRequest;
import ru.lemonade.UserService.response.JwtResponse;
import ru.lemonade.UserService.security.LUserDetails;
import ru.lemonade.UserService.security.jwt.JwtProvider;
import ru.lemonade.UserService.security.util.RefreshStorage;
import ru.lemonade.UserService.service.security.LUserDetailsService;

import java.util.Collections;
import java.util.List;

@ExtendWith(MockitoExtension.class)
public class AuthServiceTest {

    @Mock
    private LUserDetailsService userDetailsService;

    @Mock
    private RefreshStorage refreshStorage;

    @Mock
    private JwtProvider jwtProvider;

    @Mock
    private PasswordEncoder passwordEncoder;

    @InjectMocks
    private AuthService authService;

    private LUserDetails testUserDetails;
    private AuthRequest authRequest;
    private LUser user;

    @BeforeEach
    void setUp() {
        // Создаем тестового пользователя
        Role role = new Role();
        role.setId(1);
        role.setTitle("ROLE_USER");
        user = new LUser();
        user.setId(1);
        user.addRole(role);
        user.setEmail("john@example.com");
        user.setUsername("john");
        user.setPassword("encodedPassword");
        testUserDetails = new LUserDetails(user);

        // Создаем запрос на аутентификацию
        authRequest = new AuthRequest();
        authRequest.setUsername("john@example.com");
        authRequest.setPassword("password123");
    }

    @Test
    void testLogin_Success() throws AuthException {
        // Arrange: Настройка моков
        when(userDetailsService.loadUserByUsername(authRequest.getUsername())).thenReturn(testUserDetails);
        when(passwordEncoder.matches(authRequest.getPassword(), testUserDetails.getPassword())).thenReturn(true);
        when(jwtProvider.generateAccessToken(testUserDetails)).thenReturn("accessToken");
        when(jwtProvider.generateRefreshToken(testUserDetails)).thenReturn("refreshToken");

        // Act: Вызов метода сервиса
        JwtResponse response = authService.login(authRequest);

        // Assert: Проверяем результат
        assertThat(response.getAccessToken()).isEqualTo("accessToken");
        assertThat(response.getRefreshToken()).isEqualTo("refreshToken");

        // Verify: Проверяем взаимодействие с зависимостями
        verify(userDetailsService).loadUserByUsername(authRequest.getUsername());
        verify(passwordEncoder).matches(authRequest.getPassword(), testUserDetails.getPassword());
        verify(jwtProvider).generateAccessToken(testUserDetails);
        verify(jwtProvider).generateRefreshToken(testUserDetails);
        verify(refreshStorage).put(testUserDetails.getUsername(), "refreshToken");
    }

    @Test
    void testLogin_UserDisabled() {
        // Arrange: Настройка моков
        user.setEnabled(false);
        testUserDetails = new LUserDetails(user);
        when(userDetailsService.loadUserByUsername(authRequest.getUsername())).thenReturn(testUserDetails);

        // Act & Assert: Проверяем, что выбрасывается исключение DisabledException
        assertThrows(DisabledException.class, () -> {
            authService.login(authRequest);
        });

        // Verify: Проверяем взаимодействие с зависимостями
        verify(userDetailsService).loadUserByUsername(authRequest.getUsername());
        verify(refreshStorage).banToken(testUserDetails.getUsername());
    }

    @Test
    void testLogin_WrongPassword() {
        // Arrange: Настройка моков
        when(userDetailsService.loadUserByUsername(authRequest.getUsername())).thenReturn(testUserDetails);
        when(passwordEncoder.matches(authRequest.getPassword(), testUserDetails.getPassword())).thenReturn(false);

        // Act & Assert: Проверяем, что выбрасывается исключение AuthException
        AuthException exception = assertThrows(AuthException.class, () -> {
            authService.login(authRequest);
        });

        assertThat(exception.getMessage()).isEqualTo("Wrong password");

        // Verify: Проверяем взаимодействие с зависимостями
        verify(userDetailsService).loadUserByUsername(authRequest.getUsername());
        verify(passwordEncoder).matches(authRequest.getPassword(), testUserDetails.getPassword());
    }

    @Test
    void testGetNewAccessToken_Success() throws AuthException {
        // Arrange: Настройка моков
        String refreshToken = "validRefreshToken";
        String username = "john@example.com";

        Claims claims = mock(Claims.class);
        when(jwtProvider.validateRefreshToken(refreshToken)).thenReturn(true);
        when(jwtProvider.getRefreshClaims(refreshToken)).thenReturn(claims);
        when(claims.getSubject()).thenReturn(username);
        when(refreshStorage.get(username)).thenReturn(refreshToken);
        when(refreshStorage.isNotInBlackList(username)).thenReturn(true);
        when(userDetailsService.loadUserByUsername(username)).thenReturn(testUserDetails);
        when(jwtProvider.generateAccessToken(testUserDetails)).thenReturn("newAccessToken");
        when(jwtProvider.generateRefreshToken(testUserDetails)).thenReturn("newRefreshToken");

        // Act: Вызов метода сервиса
        JwtResponse response = authService.getNewAccessToken(refreshToken);

        // Assert: Проверяем результат
        assertThat(response.getAccessToken()).isEqualTo("newAccessToken");
        assertThat(response.getRefreshToken()).isEqualTo("newRefreshToken");

        // Verify: Проверяем взаимодействие с зависимостями
        verify(jwtProvider).validateRefreshToken(refreshToken);
        verify(jwtProvider).getRefreshClaims(refreshToken);
        verify(refreshStorage).get(username);
        verify(refreshStorage).isNotInBlackList(username);
        verify(userDetailsService).loadUserByUsername(username);
        verify(jwtProvider).generateAccessToken(testUserDetails);
        verify(jwtProvider).generateRefreshToken(testUserDetails);
        verify(refreshStorage).put(username, "newRefreshToken");
    }

    @Test
    void testGetNewAccessToken_InvalidRefreshToken() {
        // Arrange: Настройка моков
        String refreshToken = "invalidRefreshToken";
        when(jwtProvider.validateRefreshToken(refreshToken)).thenReturn(false);

        // Act & Assert: Проверяем, что выбрасывается исключение AuthException
        AuthException exception = assertThrows(AuthException.class, () -> {
            authService.getNewAccessToken(refreshToken);
        });

        assertThat(exception.getMessage()).isEqualTo("wrong refresh token");

        // Verify: Проверяем взаимодействие с зависимостями
        verify(jwtProvider).validateRefreshToken(refreshToken);
    }

    @Test
    void testLogout_Success() throws AuthException {
        // Arrange: Настройка моков
        String refreshToken = "validRefreshToken";
        String username = "john@example.com";

        Claims claims = mock(Claims.class);
        when(jwtProvider.validateRefreshToken(refreshToken)).thenReturn(true);
        when(jwtProvider.getRefreshClaims(refreshToken)).thenReturn(claims);
        when(claims.getSubject()).thenReturn(username);
        when(refreshStorage.get(username)).thenReturn(refreshToken);
        when(refreshStorage.isNotInBlackList(username)).thenReturn(true);

        // Act: Вызов метода сервиса
        authService.logout(refreshToken);

        // Verify: Проверяем взаимодействие с зависимостями
        verify(jwtProvider).validateRefreshToken(refreshToken);
        verify(jwtProvider).getRefreshClaims(refreshToken);
        verify(refreshStorage).get(username);
        verify(refreshStorage).isNotInBlackList(username);
        verify(refreshStorage).banToken(username);
    }

    @Test
    void testLogout_InvalidRefreshToken() {
        // Arrange: Настройка моков
        String refreshToken = "invalidRefreshToken";
        when(jwtProvider.validateRefreshToken(refreshToken)).thenReturn(false);

        // Act & Assert: Проверяем, что выбрасывается исключение InvalidTokenException
        InvalidTokenException exception = assertThrows(InvalidTokenException.class, () -> {
            authService.logout(refreshToken);
        });

        assertThat(exception.getMessage()).isEqualTo("wrong refresh token");

        // Verify: Проверяем взаимодействие с зависимостями
        verify(jwtProvider).validateRefreshToken(refreshToken);
    }
}