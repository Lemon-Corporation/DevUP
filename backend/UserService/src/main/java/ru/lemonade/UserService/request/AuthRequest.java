package ru.lemonade.UserService.request;

import jakarta.validation.constraints.NotNull;

public class AuthRequest {
    @NotNull
    private String username;
    @NotNull
    private String password;

    public AuthRequest(String email, String password) {
        this.username = email;
        this.password = password;
    }

    public AuthRequest() {}

    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
