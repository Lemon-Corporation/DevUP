package ru.lemonade.UserService.service;

import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import ru.lemonade.UserService.dto.LUserDefaultDto;
import ru.lemonade.UserService.dto.LUserProfileDto;
import ru.lemonade.UserService.dto.LUserProfilePublicDto;
import ru.lemonade.UserService.dto.LUserRegistrationDto;
import ru.lemonade.UserService.error.exception.*;
import ru.lemonade.UserService.mapper.LUserDefaultMapper;
import ru.lemonade.UserService.mapper.LUserProfileMapper;
import ru.lemonade.UserService.mapper.LUserProfilePublicMapper;
import ru.lemonade.UserService.model.LUser;
import ru.lemonade.UserService.model.PasswordResetToken;
import ru.lemonade.UserService.model.Role;
import ru.lemonade.UserService.repository.LUserRepository;
import ru.lemonade.UserService.repository.PasswordResetTokenRepository;
import ru.lemonade.UserService.repository.RoleRepository;
import ru.lemonade.UserService.request.ChangePasswordRequest;
import ru.lemonade.UserService.security.LUserDetails;
import ru.lemonade.UserService.settings.Constants;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class LUserService {
    private final LUserRepository lUserRepository;
    private final PasswordEncoder passwordEncoder;
    private final RoleRepository roleRepository;
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    private final String defaultRoleName = Constants.DEFAULT_ROLE_TITLE;

    public LUserService(LUserRepository lUserRepository, PasswordEncoder passwordEncoder,
                        RoleRepository roleRepository, PasswordResetTokenRepository passwordResetTokenRepository) {
        this.lUserRepository = lUserRepository;
        this.passwordEncoder = passwordEncoder;
        this.roleRepository = roleRepository;
        this.passwordResetTokenRepository = passwordResetTokenRepository;
    }

    public void save(LUserRegistrationDto newUser) throws RoleNotFoundException, InvalidPasswordException {

        Role defaultRole = roleRepository.getByTitle(defaultRoleName).orElseThrow(
                () -> new RoleNotFoundException("Default Role not found. Default Role: " + defaultRoleName)
        );
        String password = newUser.getPassword();
        validatePassword(password);

        LUser user = new LUser();
        user.setUsername(newUser.getUsername());
        user.setEmail(newUser.getEmail());
        user.setPassword(passwordEncoder.encode(password));
        user.addRole(defaultRole);
        lUserRepository.save(user);
    }

    public List<LUserDefaultDto> findAllUsers() {
        return lUserRepository.findAll().stream()
                .map(LUserDefaultMapper::toDto)
                .collect(Collectors.toList());
    }

    public LUserDefaultDto findUserById(long id) throws UserNotFoundException {
        return LUserDefaultMapper.toDto(
                lUserRepository.findById(id).orElseThrow(
                        () -> new UserNotFoundException("Wrong id")
                )
        );
    }

    public void changePassword(String token, ChangePasswordRequest request)
            throws InvalidResetTokenException, UserNotFoundException, ExpiredTokenException, InvalidPasswordException {
        String oldPassword = request.getOldPassword();
        String newPassword = request.getNewPassword();
        PasswordResetToken resetToken = passwordResetTokenRepository.findByToken(token).orElseThrow(
                () -> new InvalidResetTokenException("Wrong reset token")
        );
        if (resetToken.isExpired()) {
            throw new ExpiredTokenException("Token expired");
        }
        LUser user = lUserRepository.findById(resetToken.getUserId()).orElseThrow(
                () -> new UserNotFoundException("Wrong user id")
        );
        if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
            throw new InvalidPasswordException("Wrong password");
        }
        validatePassword(newPassword);

        user.setPassword(passwordEncoder.encode(newPassword));
        lUserRepository.save(user);
        passwordResetTokenRepository.delete(resetToken);
    }

    public LUserProfilePublicDto getProfilePublic(long id) throws UserNotFoundException {
        LUser user = lUserRepository.findById(id).orElseThrow(
                () -> new UserNotFoundException("No User with such id: " + id)
        );
        return LUserProfilePublicMapper.toDto(user);
    }

    public LUserProfileDto getProfile(long id) throws UserNotFoundException {
        LUser user = lUserRepository.findById(id).orElseThrow(
                () -> new UserNotFoundException("No user with such id: " + id)
        );
        return LUserProfileMapper.toDto(user);
    }

    public LUserProfileDto updateProfile(Authentication auth, LUserProfileDto profileDto) {
        LUserDetails userDetails = (LUserDetails) auth.getDetails();
        LUser user = userDetails.getUser();

        user.setUsername(profileDto.getUsername());
        user.setEmail(profileDto.getEmail());
        lUserRepository.save(user);
        return LUserProfileMapper.toDto(user);
    }

    private void validatePassword(String password) throws InvalidPasswordException {
        if (password == null || password.length() < 8) {
            throw new InvalidPasswordException("Password should be at least 8 characters long");
        }
        boolean isContainsChars = false;
        boolean isContainsDigits = false;
        for (int i = 0; i < password.length(); i++) {
            char c = password.charAt(i);
            if (Character.isDigit(c)) {
                isContainsDigits = true;
            } else if (Character.isLetter(c)) {
                isContainsChars = true;
            }
        }
        if (!isContainsChars || !isContainsDigits) {
            throw new InvalidPasswordException("Password should contain digits and letters");
        }
    }
}
