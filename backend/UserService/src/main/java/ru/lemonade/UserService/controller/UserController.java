package ru.lemonade.UserService.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import ru.lemonade.UserService.dto.LUserDefaultDto;
import ru.lemonade.UserService.dto.LUserProfileDto;
import ru.lemonade.UserService.dto.LUserProfilePublicDto;
import ru.lemonade.UserService.dto.LUserRegistrationDto;
import ru.lemonade.UserService.error.exception.*;
import ru.lemonade.UserService.request.ChangePasswordRequest;
import ru.lemonade.UserService.service.LUserService;
import ru.lemonade.UserService.settings.ApiPath;
import java.util.List;

@RestController
@RequestMapping(ApiPath.USER_CONTROLLER_PATH)
@Tag(
        name = "User Controller",
        description = "allows to manage users and get users data"
)
public class UserController {
    LUserService userService;

    public UserController(LUserService userService) {
        this.userService = userService;
    }


    @SecurityRequirement(name = "JWT")
    @GetMapping("all")
    public List<LUserDefaultDto> getAllUsers() {
        return userService.findAllUsers();
    }

    @PostMapping("create")
    @Operation(summary = "Allows you to create account")
    public void createUser(@RequestBody LUserRegistrationDto userDto) throws RoleNotFoundException, InvalidPasswordException {
        userService.save(userDto);
    }


    @SecurityRequirement(name = "JWT")
    @GetMapping("{id}")
    public LUserDefaultDto getUser(@PathVariable long id) throws UserNotFoundException {
        return userService.findUserById(id);
    }

    @SecurityRequirement(name = "JWT")
    @GetMapping("profile")
    @Operation(
            description = "later will be connect with other services and return all data for user profile",
            summary = "returns user data profile"
    )
    public LUserProfileDto getUserProfile() throws UserNotFoundException {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return userService.getProfile((long) authentication.getPrincipal());
    }

    @SecurityRequirement(name = "JWT")
    @PutMapping("update-profile")
    public LUserProfileDto updateUserProfile(LUserProfileDto dto) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return userService.updateProfile(authentication, dto);
    }

    @SecurityRequirement(name = "JWT")
    @GetMapping("profile/{id}")
    @Operation(summary = "return only public user data for profile")
    public LUserProfilePublicDto getUserProfileById(@PathVariable long id) throws UserNotFoundException {
        return userService.getProfilePublic(id);
    }

    @PutMapping("change-password")
    public ResponseEntity<?> changePassword(@RequestParam String token, @RequestBody ChangePasswordRequest request)
            throws UserNotFoundException, ExpiredTokenException, InvalidPasswordException, InvalidResetTokenException {
        userService.changePassword(token, request);
        return ResponseEntity.ok().build();
    }
}
