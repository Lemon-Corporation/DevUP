package ru.lemonade.UserService.response;

public class JwtRefreshResponse {
    private String refreshToken;

    public JwtRefreshResponse() {}
    public JwtRefreshResponse(String refreshToken) {
        this.refreshToken = refreshToken;
    }
    public String getRefreshToken() {
        return refreshToken;
    }
    public void setRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }
}
