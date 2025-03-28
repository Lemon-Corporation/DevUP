package ru.lemonade.UserService.model;

import jakarta.persistence.*;
import org.apache.commons.text.RandomStringGenerator;
import ru.lemonade.UserService.security.util.JwtUtil;
import ru.lemonade.UserService.settings.Constants;

import java.util.Date;
import java.util.UUID;

@Entity
@Table(name = "password_reset_tokens")
public class PasswordResetToken {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false)
    private long userId;

    @Column(nullable = false)
    private String token;

    private Date expirationAt;

    private Date createdAt;


    public PasswordResetToken() {
        this.createdAt = new Date();
    }

    private PasswordResetToken(long expirationInSeconds) {
        this();
        this.expirationAt = new Date(this.createdAt.getTime() + expirationInSeconds * 1000);
    }

    public PasswordResetToken(long userId, String token, long expirationSeconds) {
        this(expirationSeconds);
        this.token = token;
        this.userId = userId;
    }


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Date getExpirationAt() {
        return expirationAt;
    }

    public void setExpirationAt(Date expirationAt) {
        this.expirationAt = expirationAt;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    // Метод для проверки, истек ли срок действия токена
    public boolean isExpired() {
        return new Date().after(this.expirationAt);
    }
}