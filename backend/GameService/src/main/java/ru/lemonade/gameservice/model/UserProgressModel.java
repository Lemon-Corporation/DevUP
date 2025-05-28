package ru.lemonade.gameservice.model;

import jakarta.persistence.*;

@Entity
@Table(name = "user_progress")
public class UserProgressModel {
    @Id
    @GeneratedValue
    private Long id;
    @Column(name= "user_id", nullable = false)
    private long userId;
    @Column(name= "progress_points", nullable = false)
    private int points;
    @Column(name= "level", nullable = false)
    private int level;

    public UserProgressModel() {

    }

    public long getUserId() {
        return userId;
    }

    public int getPoints() {
        return points;
    }

    public int getLevel() {
        return level;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public void setLevel(int level) {
        this.level = level;
    }
}
