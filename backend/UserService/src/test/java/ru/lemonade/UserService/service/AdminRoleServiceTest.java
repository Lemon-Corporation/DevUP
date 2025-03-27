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
import ru.lemonade.UserService.model.Role;
import ru.lemonade.UserService.repository.RoleRepository;
import ru.lemonade.UserService.service.admin.AdminRoleService;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@ExtendWith(MockitoExtension.class)
public class AdminRoleServiceTest {

    @Mock
    private RoleRepository roleRepository;

    @InjectMocks
    private AdminRoleService adminRoleService;

    private Role testRole;

    @BeforeEach
    void setUp() {
        // Создаем тестовую роль
        testRole = new Role();
        testRole.setId(1);
        testRole.setTitle("ADMIN");
    }

    @Test
    void testGetRole_Success() throws RoleNotFoundException {
        // Arrange: Настройка мока
        String roleName = "ADMIN";
        when(roleRepository.getByTitle(roleName)).thenReturn(Optional.of(testRole));

        // Act: Вызов метода сервиса
        Role result = adminRoleService.getRole(roleName);

        // Assert: Проверка результата
        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(1);
        assertThat(result.getTitle()).isEqualTo("ADMIN");

        // Verify: Проверка взаимодействия с репозиторием
        verify(roleRepository).getByTitle(roleName);
    }

    @Test
    void testGetRole_RoleNotFound() {
        // Arrange: Настройка мока
        String roleName = "NON_EXISTENT_ROLE";
        when(roleRepository.getByTitle(roleName)).thenReturn(Optional.empty());

        // Act & Assert: Проверяем, что выбрасывается исключение
        RoleNotFoundException exception = assertThrows(RoleNotFoundException.class, () -> {
            adminRoleService.getRole(roleName);
        });

        assertThat(exception.getMessage()).isEqualTo("No role with title: NON_EXISTENT_ROLE");

        // Verify: Проверка взаимодействия с репозиторием
        verify(roleRepository).getByTitle(roleName);
    }

    @Test
    void testGetRoleById_Success() throws RoleNotFoundException {
        // Arrange: Настройка мока
        long roleId = 1L;
        when(roleRepository.findById(roleId)).thenReturn(Optional.of(testRole));

        // Act: Вызов метода сервиса
        Role result = adminRoleService.getRoleById(roleId);

        // Assert: Проверка результата
        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(1);
        assertThat(result.getTitle()).isEqualTo("ADMIN");

        // Verify: Проверка взаимодействия с репозиторием
        verify(roleRepository).findById(roleId);
    }

    @Test
    void testGetRoleById_RoleNotFound() {
        // Arrange: Настройка мока
        long roleId = 999L;
        when(roleRepository.findById(roleId)).thenReturn(Optional.empty());

        // Act & Assert: Проверяем, что выбрасывается исключение
        RoleNotFoundException exception = assertThrows(RoleNotFoundException.class, () -> {
            adminRoleService.getRoleById(roleId);
        });

        assertThat(exception.getMessage()).isEqualTo("Not such role with id: 999");

        // Verify: Проверка взаимодействия с репозиторием
        verify(roleRepository).findById(roleId);
    }

    @Test
    void testGetAllRoles() {
        // Arrange: Настройка мока
        List<Role> roles = Arrays.asList(
                new Role("ADMIN"),
                new Role("USER")
        );
        when(roleRepository.findAll()).thenReturn(roles);

        // Act: Вызов метода сервиса
        List<Role> result = adminRoleService.getAllRoles();

        // Assert: Проверка результата
        assertThat(result).isNotEmpty();
        assertThat(result).hasSize(2);
        assertThat(result.get(0).getTitle()).isEqualTo("ADMIN");
        assertThat(result.get(1).getTitle()).isEqualTo("USER");

        // Verify: Проверка взаимодействия с репозиторием
        verify(roleRepository).findAll();
    }

    @Test
    void testCreateRole() {
        // Arrange: Создаем новую роль
        Role newRole = new Role("MODERATOR");

        // Act: Вызов метода сервиса
        adminRoleService.createRole(newRole);

        // Assert: Нет возвращаемого значения, проверяем только вызов метода
        verify(roleRepository).save(newRole);
    }

    @Test
    void testCreateRolesMultiple() {
        // Arrange: Создаем список ролей
        List<Role> roles = Arrays.asList(
                new Role("EDITOR"),
                new Role("VIEWER")
        );

        // Act: Вызов метода сервиса
        adminRoleService.createRolesMultiple(roles);

        // Assert: Нет возвращаемого значения, проверяем только вызов метода
        verify(roleRepository).saveAll(roles);
    }
}