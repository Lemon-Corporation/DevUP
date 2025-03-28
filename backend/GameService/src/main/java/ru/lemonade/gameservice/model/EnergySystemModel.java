package ru.lemonade.gameservice.model;

import jakarta.persistence.*;

@Entity
@Table(name = "energy")
public class EnergySystemModel {
    @Id @GeneratedValue private Long id;
    @Column(name="userId", nullable = false)
    private long userId;
    @Column(name="currentAmount", nullable = false)
    private int currentAmount;

    @Column(name="maxAmount", nullable = false)
    private int maxAmount;

    public EnergySystemModel() {

    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public int getCurrentAmount() {
        return currentAmount;
    }

    public void setCurrentAmount(int amount) {
        this.currentAmount = amount;
    }

    public int getMaxAmount() {
        return maxAmount;
    }

    public void setMaxAmount(int maxAmount) {
        this.maxAmount = maxAmount;
    }
}
