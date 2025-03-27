package ru.lemonade.UserService.service.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import ru.lemonade.UserService.model.LUser;
import ru.lemonade.UserService.repository.LUserRepository;
import ru.lemonade.UserService.security.LUserDetails;

import java.util.Optional;

@Service
public class LUserDetailsService implements UserDetailsService {
    @Autowired
    LUserRepository lUserRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<LUser> oUser = lUserRepository.findByUsername(username);
        LUser user = oUser.orElseThrow(() -> new UsernameNotFoundException(username));
        return new LUserDetails(user);
    }

    public UserDetails loadUserByEmail(String email) throws UsernameNotFoundException {
        Optional<LUser> oUser = lUserRepository.findByEmail(email);
        LUser user = oUser.orElseThrow(() -> new UsernameNotFoundException(email));
        return new LUserDetails(user);
    }
}
