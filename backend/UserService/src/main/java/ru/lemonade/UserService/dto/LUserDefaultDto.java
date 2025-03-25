package ru.lemonade.UserService.dto;

public class LUserDefaultDto {
    public long id;
    public String username;
    public String email;

    public LUserDefaultDto(long id, String username, String email) {
        this.id = id;
        this.username = username;
        this.email = email;
    }
    public LUserDefaultDto() {}

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}

