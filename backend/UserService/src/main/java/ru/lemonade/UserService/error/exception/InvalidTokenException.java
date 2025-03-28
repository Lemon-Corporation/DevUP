package ru.lemonade.UserService.error.exception;

import jakarta.security.auth.message.AuthException;

public class InvalidTokenException extends AuthException {
    public InvalidTokenException(String message) {
        super(message);
    }
}
