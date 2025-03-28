package ru.lemonade.UserService.response;

public class JwtAccessResponse {
    private String accessToken;

    public JwtAccessResponse() {
    }

    public JwtAccessResponse(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }
}
