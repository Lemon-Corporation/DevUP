package ru.lemonade.UserService.response;

import ru.lemonade.UserService.settings.Constants;

public class JwtResponse {
    private final String type = "Bearer";
    private String accessToken;
    private String refreshToken;
    private int expiresIn = Constants.accessTokenSeconds;

    public JwtResponse() {}

     public JwtResponse(String accessToken, String refreshToken) {
         this.accessToken = accessToken;
         this.refreshToken = refreshToken;
     }

     public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
     }
     public void setRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
     }

    public String getAccessToken() {
        return accessToken;
    }

    public String getRefreshToken() {
        return refreshToken;
    }

    public int getExpiresIn() {
        return expiresIn;
    }

    public void setExpiresIn(int expiresIn) {
        this.expiresIn = expiresIn;
    }

    public String getType() {
        return type;
    }
}
