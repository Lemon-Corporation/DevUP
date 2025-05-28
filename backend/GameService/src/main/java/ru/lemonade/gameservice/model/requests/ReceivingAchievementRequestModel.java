package ru.lemonade.gameservice.model.requests;

public class ReceivingAchievementRequestModel {
    private String userId;
    private String achievementId;

    public String getAchievementId() {
        return achievementId;
    }

    public String getUserId() {
        return userId;
    }
}
