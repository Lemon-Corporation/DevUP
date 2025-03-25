package ru.lemonade.UserService.cotroller;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import ru.lemonade.UserService.controller.UserController;
import ru.lemonade.UserService.dto.LUserDefaultDto;
import ru.lemonade.UserService.dto.LUserRegistrationDto;
import ru.lemonade.UserService.error.exception.InvalidPasswordException;
import ru.lemonade.UserService.error.exception.RoleNotFoundException;
import ru.lemonade.UserService.error.exception.UserNotFoundException;
import ru.lemonade.UserService.service.LUserService;

import java.util.List;
import java.util.stream.LongStream;

@ExtendWith(MockitoExtension.class)
public class UserControllerTest {
    @Mock
    LUserService lUserService;

    @InjectMocks
    UserController userController;

    @Test
    @DisplayName("UserController GetAllUsers method with valid list of users")
    void handleGetAllUsers_ReturnsValidUsers() {
        // given
        List<LUserDefaultDto> users = generateUsers(5);
        when(lUserService.findAllUsers()).thenReturn(users);
        // when
        List<LUserDefaultDto> result = userController.getAllUsers();
        // then
        assertNotNull(result);
        assertEquals(users, result);

        verify(lUserService).findAllUsers();
    }

    @Test
    void testCreateUser_Success() throws RoleNotFoundException, InvalidPasswordException {
        // Arrange: Создаем тестовые данные
        LUserRegistrationDto userDto = new LUserRegistrationDto("user", "test@example.com", "password");

        // Act: Вызываем метод контроллера
        userController.createUser(userDto);

        // Assert: Проверяем, что метод save был вызван с правильным аргументом
        verify(lUserService).save(userDto);
    }

    @Test
    void testCreateUser_ThrowsRoleNotFoundException() throws RoleNotFoundException, InvalidPasswordException {
        // Arrange: Создаем тестовые данные
        LUserRegistrationDto userDto = new LUserRegistrationDto("user", "test@example.com", "password");

        // Настройка мока: метод save выбрасывает исключение
        doThrow(new RoleNotFoundException("Default Role not found. Default Role: USER"))
                .when(lUserService).save(userDto);

        // Act & Assert: Проверяем, что исключение выбрасывается
        RoleNotFoundException exception = assertThrows(RoleNotFoundException.class, () -> {
            userController.createUser(userDto);
        });

        // Проверяем сообщение об ошибке
        assertEquals("Default Role not found. Default Role: USER", exception.getMessage());

        // Verify: Проверяем, что метод save был вызван
        verify(lUserService).save(userDto);
    }



    private List<LUserDefaultDto> generateUsers(int n) {
       return LongStream.range(1, n + 1)
               .mapToObj(i -> new LUserDefaultDto(
                       i,
                       "user" + i,
                       "email" + i + "@gmail.com"
               )).toList();
    }

    @Test
    void testGetUser_Success() throws UserNotFoundException {
        long userId = 1L;
        LUserDefaultDto expectedUser = new LUserDefaultDto(userId, "John", "john@example.com");

        when(lUserService.findUserById(userId)).thenReturn(expectedUser);

        LUserDefaultDto result = userController.getUser(userId);

        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(userId);
        assertThat(result.getUsername()).isEqualTo("John");
        assertThat(result.getEmail()).isEqualTo("john@example.com");

        verify(lUserService).findUserById(userId);
    }

    @Test
    void testGetUser_ThrowsUserNotFoundException() throws UserNotFoundException {
        long userId = 999L;

        doThrow(new UserNotFoundException("Wrong id"))
                .when(lUserService).findUserById(userId);

        UserNotFoundException exception = assertThrows(UserNotFoundException.class, () -> {
            userController.getUser(userId);
        });

        assertEquals("Wrong id", exception.getMessage());

        verify(lUserService).findUserById(userId);
    }


}
