package ru.lemonade.gameservice.interfaces.services;

public interface ProgressSystemService {
    String getProgress(String userId);
    String updateXp(String userId, int points);

}
