package ru.lemonade.gameservice.model;

import jakarta.persistence.*;

@Entity
@Table(name = "leaderboard")
public class LeaderboardModel {
    @Id @GeneratedValue private long id;

    @Column(name = "user_id", nullable = false)
    private long userId;

    @Column(name = "points", nullable = false)
    private int points;

    @Column(name = "position", nullable = false)
    private long userPosition;

    @Column(name = "direction", nullable = false)
    private long direction;

    public long getId() {
        return id;
    }

    public long getUserId() {
        return userId;
    }

    public int getPoints() {
        return points;
    }

    public long getUserPosition() {
        return userPosition;
    }

    public long getDirection() {
        return direction;
    }

    public void setId(long id) {
        this.id = id;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public void setUserPosition(long userPosition) {
        this.userPosition = userPosition;
    }

    public void setDirection(long direction) {
        this.direction = direction;
    }
}
