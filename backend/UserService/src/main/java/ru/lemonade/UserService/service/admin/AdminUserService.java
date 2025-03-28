package ru.lemonade.UserService.service.admin;

import org.springframework.stereotype.Service;
import ru.lemonade.UserService.error.exception.RoleNotFoundException;
import ru.lemonade.UserService.error.exception.UserNotFoundException;
import ru.lemonade.UserService.model.LUser;
import ru.lemonade.UserService.model.Role;
import ru.lemonade.UserService.repository.LUserRepository;
import ru.lemonade.UserService.repository.RoleRepository;

@Service
public class AdminUserService {
    LUserRepository lUserRepository;
    RoleRepository roleRepository;
    final String roleAdminTitle = "ROLE_ADMIN";

    public AdminUserService(LUserRepository lUserRepository, RoleRepository roleRepository) {
        this.lUserRepository = lUserRepository;
        this.roleRepository = roleRepository;
    }

    public void makeUserAdmin(long userId) throws RoleNotFoundException, UserNotFoundException {
        final LUser user = findUser(userId);
        Role adminRole = roleRepository.getByTitle(roleAdminTitle).orElseThrow(
                () -> new RoleNotFoundException("No role with title ROLE_ADMIN")
        );
        if (!user.getRoles().contains(adminRole)) {
            user.getRoles().add(adminRole);
        }
    }

    public void banUser(long userId) throws UserNotFoundException {
        final LUser user = findUser(userId);
        user.setEnabled(false);
    }

    public void unbanUser(long userId) throws UserNotFoundException {
        final LUser user = findUser(userId);
        user.setEnabled(true);
    }

    private LUser findUser(long userId) throws UserNotFoundException {
         return lUserRepository.findById(userId).orElseThrow(
                () -> new UserNotFoundException("No user with that id. Given id: " + userId)
        );
    }

}
