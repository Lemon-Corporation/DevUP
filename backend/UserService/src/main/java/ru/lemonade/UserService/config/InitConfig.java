package ru.lemonade.UserService.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;
import ru.lemonade.UserService.model.LUser;
import ru.lemonade.UserService.model.Role;
import ru.lemonade.UserService.repository.LUserRepository;
import ru.lemonade.UserService.repository.RoleRepository;
import ru.lemonade.UserService.settings.Constants;
import ru.lemonade.UserService.settings.EmailUtils;

import java.util.List;

@Configuration
public class InitConfig {
    @Bean
    public CommandLineRunner initData(RoleRepository roleRepository, LUserRepository lUserRepository, PasswordEncoder passwordEncoder) {
        return args -> {
            Role adminRole = roleRepository.getByTitle(Constants.ADMIN_ROLE_TITLE).orElseGet(() -> {
                Role role = new Role();
                role.setTitle(Constants.ADMIN_ROLE_TITLE);
                return roleRepository.save(role);
            });

            Role userRole = roleRepository.getByTitle(Constants.USER_ROLE_TITLE).orElseGet(() -> {
                Role role = new Role();
                role.setTitle(Constants.USER_ROLE_TITLE);
                return roleRepository.save(role);
            });

            if (Constants.DEBUG && lUserRepository.findByUsername("testadmin").orElse(null) == null) {
                LUser user = new LUser();
                user.setUsername("testadmin");
                user.setPassword(passwordEncoder.encode("mypassword"));
                user.setEmail(EmailUtils.generateEmail("testadmin"));
                user.addRole(adminRole);
                user.addRole(userRole);
                lUserRepository.save(user);
            }

            if (Constants.DEBUG && lUserRepository.findByUsername("testuser").orElse(null) == null) {
                LUser user = new LUser();
                user.setUsername("testuser");
                user.setPassword(passwordEncoder.encode("mypassword"));
                user.setEmail(EmailUtils.generateEmail("testuser"));
                user.addRole(userRole);
                lUserRepository.save(user);
            }

        };
    }
}
