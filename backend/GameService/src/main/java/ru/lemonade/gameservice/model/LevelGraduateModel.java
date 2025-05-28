package ru.lemonade.gameservice.model;

import jakarta.persistence.*;

@Entity
@Table(name = "levels_graduate")
public class LevelGraduateModel {
    @Id @GeneratedValue private long id;

    @Column(name= "level", nullable = false)
    private int level;

    @Column(name= "start_point", nullable = false)
    private int startPoint;

    @Column(name= "end_point", nullable = false)
    private int endPoint;

    public LevelGraduateModel() {

    }

    public int getLevel() {
        return level;
    }

    public int getStartPoint() {
        return startPoint;
    }

    public int getEndPoint() {
        return endPoint;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public void setStartPoint(int startPoint) {
        this.startPoint = startPoint;
    }

    public void setEndPoint(int endPoint) {
        this.endPoint = endPoint;
    }
}
