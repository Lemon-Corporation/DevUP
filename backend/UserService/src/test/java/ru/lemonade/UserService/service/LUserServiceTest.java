package ru.lemonade.UserService.service;

import static org.mockito.Mockito.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;
import ru.lemonade.UserService.dto.LUserDefaultDto;
import ru.lemonade.UserService.dto.LUserRegistrationDto;
import ru.lemonade.UserService.error.exception.RoleNotFoundException;
import ru.lemonade.UserService.error.exception.UserNotFoundException;
import ru.lemonade.UserService.mapper.LUserDefaultMapper;
import ru.lemonade.UserService.model.LUser;
import ru.lemonade.UserService.model.Role;
import ru.lemonade.UserService.repository.LUserRepository;
import ru.lemonade.UserService.repository.RoleRepository;
import ru.lemonade.UserService.service.LUserService;

import java.util.List;
import java.util.Optional;

@ExtendWith(MockitoExtension.class)
public class LUserServiceTest {

    @Mock
    private LUserRepository lUserRepository;

    @Mock
    private RoleRepository roleRepository;

    @Mock
    private PasswordEncoder passwordEncoder;

    @InjectMocks
    private LUserService lUserService;

    private LUser testUser;
    private Role defaultRole;

    @BeforeEach
    void setUp() {
        // Создаем тестового пользователя
        testUser = new LUser();
        testUser.setId(1L);
        testUser.setEmail("john@example.com");
        testUser.setPassword("encodedPassword");

        // Создаем тестовую роль
        defaultRole = new Role();
        defaultRole.setId(2);
        defaultRole.setTitle("ROLE_USER");
    }

    @Test
    void testSaveUser_Success() throws RoleNotFoundException {
        // Arrange: Создаем DTO для регистрации пользователя
        LUserRegistrationDto newUser = new LUserRegistrationDto();
        newUser.setUsername("john_doe");
        newUser.setEmail("john@example.com");
        newUser.setPassword("password123");

        // Настройка моков
        when(roleRepository.getByTitle("ROLE_USER")).thenReturn(Optional.of(defaultRole));
        when(passwordEncoder.encode("password123")).thenReturn("encodedPassword");

        // Act: Вызов метода сервиса
        lUserService.save(newUser);

        // Assert: Проверяем взаимодействие с репозиториями
        verify(roleRepository).getByTitle("ROLE_USER");
        verify(passwordEncoder).encode("password123");
        verify(lUserRepository).save(any(LUser.class));

        // Verify: Проверяем, что пользователь был сохранен с правильными данными
        ArgumentCaptor<LUser> userCaptor = ArgumentCaptor.forClass(LUser.class);
        verify(lUserRepository).save(userCaptor.capture());

        LUser savedUser = userCaptor.getValue();
        assertThat(savedUser.getEmail()).isEqualTo("john@example.com");
        assertThat(savedUser.getPassword()).isEqualTo("encodedPassword");
        assertThat(savedUser.getRoles()).contains(defaultRole);
    }

    @Test
    void testSaveUser_RoleNotFound() {
        // Arrange: Создаем DTO для регистрации пользователя
        LUserRegistrationDto newUser = new LUserRegistrationDto();
        newUser.setUsername("john_doe");
        newUser.setEmail("john@example.com");
        newUser.setPassword("password123");

        // Настройка мока: роль не найдена
        when(roleRepository.getByTitle("ROLE_USER")).thenReturn(Optional.empty());

        // Act & Assert: Проверяем, что выбрасывается исключение RoleNotFoundException
        RoleNotFoundException exception = assertThrows(RoleNotFoundException.class, () -> {
            lUserService.save(newUser);
        });

        assertThat(exception.getMessage()).isEqualTo("Default Role not found. Default Role: ROLE_USER");

        // Verify: Проверяем взаимодействие с репозиторием
        verify(roleRepository).getByTitle("ROLE_USER");
    }

    @Test
    void testFindAllUsers() {
        // Arrange: Настройка моков
        LUser user1 = new LUser();
        user1.setId(1L);
        user1.setEmail("user1@example.com");

        LUser user2 = new LUser();
        user2.setId(2L);
        user2.setEmail("user2@example.com");

        when(lUserRepository.findAll()).thenReturn(List.of(user1, user2));

        // Act: Вызов метода сервиса
        List<LUserDefaultDto> result = lUserService.findAllUsers();

        // Assert: Проверяем результат
        assertThat(result).hasSize(2);
        assertThat(result.get(0).getEmail()).isEqualTo("user1@example.com");
        assertThat(result.get(1).getEmail()).isEqualTo("user2@example.com");

        // Verify: Проверяем взаимодействие с репозиторием
        verify(lUserRepository).findAll();
    }

    @Test
    void testFindUserById_Success() throws Exception {
        // Arrange: Настройка моков
        long userId = 1L;
        when(lUserRepository.findById(userId)).thenReturn(Optional.of(testUser));

        // Act: Вызов метода сервиса
        LUserDefaultDto result = lUserService.findUserById(userId);

        // Assert: Проверяем результат
        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(1L);
        assertThat(result.getEmail()).isEqualTo("john@example.com");

        // Verify: Проверяем взаимодействие с репозиторием
        verify(lUserRepository).findById(userId);
    }

    @Test
    void testFindUserById_UserNotFound() {
        // Arrange: Настройка моков
        long userId = 999L;
        when(lUserRepository.findById(userId)).thenReturn(Optional.empty());

        // Act & Assert: Проверяем, что выбрасывается исключение UserNotFoundException
        UserNotFoundException exception = assertThrows(UserNotFoundException.class, () -> {
            lUserService.findUserById(userId);
        });

        assertThat(exception.getMessage()).isEqualTo("Wrong id");

        // Verify: Проверяем взаимодействие с репозиторием
        verify(lUserRepository).findById(userId);
    }
}
