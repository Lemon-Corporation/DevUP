package ru.lemonade.gameservice.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "user_achievements")
public class UserAchievementsModel {
    @Id @GeneratedValue private Long id;
    @Column(name="userId", nullable = false)
    private Long userId;
    @Column(name="achieveId", nullable = false)
    private Long achieveId;
    @Column(name="receivedAt", nullable = false)
    private LocalDateTime receivedAt;

    public UserAchievementsModel() {

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getAchieveId() {
        return achieveId;
    }

    public void setAchieveId(Long achieveId) {
        this.achieveId = achieveId;
    }

    public LocalDateTime getReceivedAt() {
        return receivedAt;
    }

    public void setReceivedAt(LocalDateTime receivedAt) {
        this.receivedAt = receivedAt;
    }
}
