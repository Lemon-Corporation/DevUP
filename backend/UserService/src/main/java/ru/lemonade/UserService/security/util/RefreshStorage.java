package ru.lemonade.UserService.security.util;

import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class RefreshStorage {
    private static class RefreshTokenInfo {
        private final String token;
        private boolean isInBlackList;
        public RefreshTokenInfo(String token) {
            this.token = token;
            this.isInBlackList = false;
        }
        public RefreshTokenInfo(String token, boolean isInBlackList) {
            this.token = token;
            this.isInBlackList = isInBlackList;
        }
        public String getToken() {
            return token;
        }
        public boolean isInBlackList() {
            return isInBlackList;
        }

        public void putInBlackList() {
            isInBlackList = true;
        }
    }
    Map<String, RefreshTokenInfo> refreshStorage;

    public RefreshStorage() {
        refreshStorage = new HashMap<>();
    }

    public void put(String username, String key) {
        refreshStorage.put(username, new RefreshTokenInfo(key));
    }

    public String get(String username) {
        return refreshStorage.get(username).getToken();
    }

    public boolean isNotInBlackList(String username) {
        return !refreshStorage.get(username).isInBlackList();
    }

    public void banToken(String username) {
        refreshStorage.get(username).putInBlackList();
    }
}
