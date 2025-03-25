package ru.lemonade.UserService.security.jwt;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import ru.lemonade.UserService.model.Role;

import java.util.Collection;
import java.util.List;

public class JwtAuthentication implements Authentication {
    private String email;
    private long id;
    private List<SimpleGrantedAuthority> roles;
    private boolean authenticated;

    public void setEmail(String email) {
        this.email = email;
    }

    public void setId(long id) {
        this.id = id;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles.stream()
                .map(role -> new SimpleGrantedAuthority(role.getTitle()))
                .toList();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return roles;
    }

    @Override
    public Object getCredentials() {
        return null;
    }

    @Override
    public Object getDetails() {
        return null;
    }

    @Override
    public Object getPrincipal() {
        return id;
    }

    @Override
    public boolean isAuthenticated() {
        return authenticated;
    }

    @Override
    public void setAuthenticated(boolean isAuthenticated) throws IllegalArgumentException {
        authenticated = isAuthenticated;
    }

    @Override
    public String getName() {
        return email;
    }
}
