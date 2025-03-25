package ru.lemonade.UserService.error.exception;

public class InvalidResetTokenException extends ApplicationException {
    public InvalidResetTokenException(String message) {
        super(message);
    }
}
