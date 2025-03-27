package ru.lemonade.UserService.service;

import static org.mockito.Mockito.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import ru.lemonade.UserService.error.exception.RoleNotFoundException;
import ru.lemonade.UserService.error.exception.UserNotFoundException;
import ru.lemonade.UserService.model.LUser;
import ru.lemonade.UserService.model.Role;
import ru.lemonade.UserService.repository.LUserRepository;
import ru.lemonade.UserService.repository.RoleRepository;
import ru.lemonade.UserService.service.admin.AdminUserService;

import java.util.Collections;
import java.util.Optional;

@ExtendWith(MockitoExtension.class)
public class AdminUserServiceTest {

    @Mock
    private LUserRepository lUserRepository;

    @Mock
    private RoleRepository roleRepository;

    @InjectMocks
    private AdminUserService adminUserService;

    private LUser testUser;
    private Role adminRole;

    @BeforeEach
    void setUp() {
        // Создаем тестового пользователя
        testUser = new LUser();
        testUser.setId(1L);
        testUser.setUsername("john_doe");
        testUser.setEmail("john@example.com");
        testUser.setPassword("password123");
        testUser.setEnabled(true);

        // Создаем тестовую роль "ROLE_ADMIN"
        adminRole = new Role();
        adminRole.setId(2);
        adminRole.setTitle("ROLE_ADMIN");
    }

    @Test
    void testMakeUserAdmin_Success() throws RoleNotFoundException, UserNotFoundException {
        // Arrange: Настройка моков
        long userId = 1L;
        when(lUserRepository.findById(userId)).thenReturn(Optional.of(testUser));
        when(roleRepository.getByTitle("ROLE_ADMIN")).thenReturn(Optional.of(adminRole));

        // Act: Вызов метода сервиса
        adminUserService.makeUserAdmin(userId);

        // Assert: Проверяем, что роль "ROLE_ADMIN" добавлена пользователю
        assertThat(testUser.getRoles()).contains(adminRole);

        // Verify: Проверка взаимодействия с репозиториями
        verify(lUserRepository).findById(userId);
        verify(roleRepository).getByTitle("ROLE_ADMIN");
    }

    @Test
    void testMakeUserAdmin_UserAlreadyHasRole() throws RoleNotFoundException, UserNotFoundException {
        // Arrange: Настройка моков
        long userId = 1L;
        testUser.addRole(adminRole); // Пользователь уже имеет роль "ROLE_ADMIN"
        when(lUserRepository.findById(userId)).thenReturn(Optional.of(testUser));
        when(roleRepository.getByTitle("ROLE_ADMIN")).thenReturn(Optional.of(adminRole));

        // Act: Вызов метода сервиса
        adminUserService.makeUserAdmin(userId);

        // Assert: Убедимся, что роль "ROLE_ADMIN" не была добавлена повторно
        assertThat(testUser.getRoles()).hasSize(1);
        assertThat(testUser.getRoles()).contains(adminRole);

        // Verify: Проверка взаимодействия с репозиториями
        verify(lUserRepository).findById(userId);
        verify(roleRepository).getByTitle("ROLE_ADMIN");
    }

    @Test
    void testMakeUserAdmin_RoleNotFound() {
        // Arrange: Настройка моков
        long userId = 1L;
        when(lUserRepository.findById(userId)).thenReturn(Optional.of(testUser));
        when(roleRepository.getByTitle("ROLE_ADMIN")).thenReturn(Optional.empty());

        // Act & Assert: Проверяем, что выбрасывается исключение RoleNotFoundException
        RoleNotFoundException exception = assertThrows(RoleNotFoundException.class, () -> {
            adminUserService.makeUserAdmin(userId);
        });

        assertThat(exception.getMessage()).isEqualTo("No role with title ROLE_ADMIN");

        // Verify: Проверка взаимодействия с репозиториями
        verify(lUserRepository).findById(userId);
        verify(roleRepository).getByTitle("ROLE_ADMIN");
    }

    @Test
    void testBanUser_Success() throws UserNotFoundException {
        // Arrange: Настройка моков
        long userId = 1L;
        when(lUserRepository.findById(userId)).thenReturn(Optional.of(testUser));

        // Act: Вызов метода сервиса
        adminUserService.banUser(userId);

        // Assert: Проверяем, что пользователь забанен
        assertThat(testUser.isEnabled()).isFalse();

        // Verify: Проверка взаимодействия с репозиторием
        verify(lUserRepository).findById(userId);
    }

    @Test
    void testUnbanUser_Success() throws UserNotFoundException {
        // Arrange: Настройка моков
        long userId = 1L;
        testUser.setEnabled(false); // Пользователь изначально забанен
        when(lUserRepository.findById(userId)).thenReturn(Optional.of(testUser));

        // Act: Вызов метода сервиса
        adminUserService.unbanUser(userId);

        // Assert: Проверяем, что пользователь разбанен
        assertThat(testUser.isEnabled()).isTrue();

        // Verify: Проверка взаимодействия с репозиторием
        verify(lUserRepository).findById(userId);
    }

    @Test
    void testFindUser_UserNotFound() {
        // Arrange: Настройка моков
        long userId = 999L;
        when(lUserRepository.findById(userId)).thenReturn(Optional.empty());

        // Act & Assert: Проверяем, что выбрасывается исключение UserNotFoundException
        UserNotFoundException exception = assertThrows(UserNotFoundException.class, () -> {
            adminUserService.makeUserAdmin(userId);
        });

        assertThat(exception.getMessage()).isEqualTo("No user with that id. Given id: 999");

        // Verify: Проверка взаимодействия с репозиторием
        verify(lUserRepository).findById(userId);
    }
}
