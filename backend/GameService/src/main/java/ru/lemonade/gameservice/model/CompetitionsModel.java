package ru.lemonade.gameservice.model;

import jakarta.persistence.*;

import java.lang.reflect.Array;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@Entity
@Table(name = "competitions")
public class CompetitionsModel {
    @Id @GeneratedValue private Long id;
    @Column(name="compName", nullable = false)
    private String compName;
    @Column(name="announcedAt", nullable = false)
    private LocalDateTime announcedAt;
    @Column(name="startAt", nullable = false)
    private LocalDateTime startAt;
    @Column(name="endAt", nullable = false)
    private LocalDateTime endAt;
    @Column(name="participantsIds", nullable = false)
    private long[] participantsIds;

    public CompetitionsModel() {

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCompName() {
        return compName;
    }

    public void setCompName(String compName) {
        this.compName = compName;
    }

    public LocalDateTime getAnnouncedAt() {
        return announcedAt;
    }

    public void setAnnouncedAt(LocalDateTime announcedAt) {
        this.announcedAt = announcedAt;
    }

    public LocalDateTime getStartAt() {
        return startAt;
    }

    public void setStartAt(LocalDateTime startAt) {
        this.startAt = startAt;
    }

    public LocalDateTime getEndAt() {
        return endAt;
    }

    public void setEndAt(LocalDateTime endAt) {
        this.endAt = endAt;
    }

    public long[] getParticipantsIds() {
        return participantsIds;
    }

    public void setParticipantsIds(List<Long> participantsIds) {
        long[] array = new long[participantsIds.size()];

        for (int i = 0; i < array.length; ++i) {
            array[i] = participantsIds.get(i);
        }

        this.participantsIds = array;
    }
}
