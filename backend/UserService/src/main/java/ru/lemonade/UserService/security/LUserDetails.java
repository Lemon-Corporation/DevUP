package ru.lemonade.UserService.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import ru.lemonade.UserService.model.LUser;
import ru.lemonade.UserService.model.Role;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

public class LUserDetails implements UserDetails {
    LUser user;

    public LUserDetails(LUser user) {
        this.user = user;
    }

    public LUser getUser() {
        return user;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Set<Role> roles = user.getRoles();
        List<SimpleGrantedAuthority> authorities = new ArrayList<>();
        for (Role role : roles) {
            authorities.add(new SimpleGrantedAuthority(role.getTitle()));
        }
        return authorities;
    }

    @Override
    public String getPassword() {
        return user.getPassword();
    }

    @Override
    public String getUsername() {
        return user.getUsername();
    }

    @Override
    public boolean isEnabled() {
        return user.isEnabled();
    }

    public Set<Role> getRoles() {
        return user.getRoles();
    }

    public long getId() {
        return user.getId();
    }
}
