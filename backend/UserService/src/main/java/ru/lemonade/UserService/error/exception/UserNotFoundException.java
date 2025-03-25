package ru.lemonade.UserService.error.exception;

public class UserNotFoundException extends ApplicationException{
    public UserNotFoundException(String message){
        super(message);
    }
}
