package ru.lemonade.UserService.error.exception;

public class InvalidPasswordException extends ApplicationException {
    public InvalidPasswordException(String message) {
        super(message);
    }
}
