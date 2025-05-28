package ru.lemonade.gameservice.model;

import jakarta.persistence.*;

@Entity
@Table(name = "achievements_reserve")
public class AchievementsModel {
    @Id @GeneratedValue private Long id;
    @Column(name= "achieve_name", nullable = false)
    private String achieveName;
    @Column(name= "achieve_img_url", nullable = false)
    private String achieveImgUrl;
    @Column(name= "receive_condition", nullable = false)
    private String receiveCondition;

    public AchievementsModel() {

    }

    public String getAchieveName() {
        return achieveName;
    }

    public void setAchieveName(String achieveName) {
        this.achieveName = achieveName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAchieveImgUrl() {
        return achieveImgUrl;
    }

    public void setAchieveImgUrl(String achieveImgUrl) {
        this.achieveImgUrl = achieveImgUrl;
    }

    public String getReceiveCondition() {
        return receiveCondition;
    }

    public void setReceiveCondition(String receiveCondition) {
        this.receiveCondition = receiveCondition;
    }
}
