package ru.lemonade.UserService.error.exception;

public class ExpiredTokenException extends ApplicationException {
    public ExpiredTokenException(String message) {
        super(message);
    }
}
