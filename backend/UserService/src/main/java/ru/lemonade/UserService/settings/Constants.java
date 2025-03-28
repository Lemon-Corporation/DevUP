package ru.lemonade.UserService.settings;

import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class Constants {
    public static final int accessTokenSeconds = 15 * 60;
    public static final int refreshTokenSeconds = 60 * 60;
    public static final int resetPasswordsTokenLength = 24;
    public static final int resetPasswordsTokenSeconds = 20 * 60;

    public static final String USER_ROLE_TITLE = "ROLE_USER";
    public static final String ADMIN_ROLE_TITLE = "ROLE_ADMIN";

    public static final String DEFAULT_ROLE_TITLE = USER_ROLE_TITLE;

    @Value("${spring.application.DEBUG}")
    public boolean PRE_DEBUG;
    public static boolean DEBUG;

    @PostConstruct
    public void init() {
        DEBUG = PRE_DEBUG;
    }
}
