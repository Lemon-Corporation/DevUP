package ru.lemonade.UserService.error.exception;

public class RoleNotFoundException extends ApplicationException {
    public RoleNotFoundException(String message) {
        super(message);
    }
}