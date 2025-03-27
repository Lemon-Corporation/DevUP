package ru.lemonade.UserService.settings;

public class EmailUtils {
    public static String generateEmail(String username) {
        return username + "@lemonade.org";
    }
}
