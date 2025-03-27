package ru.lemonade.UserService.dto;

public class LUserRegistrationDto {
    private String username;
    private String email;
    private String password;

    public LUserRegistrationDto() {}
    public LUserRegistrationDto(String username, String email, String password) {
        this.username = email;
        this.password = password;
        this.email = email;
    }
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
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
}
