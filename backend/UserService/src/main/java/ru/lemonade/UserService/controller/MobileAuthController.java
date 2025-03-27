package ru.lemonade.UserService.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.security.auth.message.AuthException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.lemonade.UserService.model.PasswordResetToken;
import ru.lemonade.UserService.request.AuthRequest;
import ru.lemonade.UserService.request.ForgotPasswordRequest;
import ru.lemonade.UserService.request.RefreshJwtRequest;
import ru.lemonade.UserService.response.JwtAccessResponse;
import ru.lemonade.UserService.response.JwtRefreshResponse;
import ru.lemonade.UserService.response.JwtResponse;
import ru.lemonade.UserService.service.AuthService;
import ru.lemonade.UserService.settings.ApiPath;

@RestController
@RequestMapping(ApiPath.AUTH_MOBILE_CONTROLLER_PATH)
@Tag(
        name = "Mobile Authentication",
        description = "allows you to login, logout or get new tokens"
)
public class MobileAuthController {
    private final AuthService authService;

    public MobileAuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("login")
    @Operation(summary = "allows you to get access and refresh token")
    public ResponseEntity<JwtResponse> login(@RequestBody AuthRequest authRequest) throws AuthException {
        final JwtResponse tokens = authService.login(authRequest);
        return ResponseEntity.ok(tokens);
    }

    @PostMapping("refresh")
    @Operation(summary = "allows you to get new access and refresh token token")
    public ResponseEntity<JwtResponse> getNewAccessToken(@RequestBody RefreshJwtRequest request) throws AuthException {
        final JwtResponse tokens = authService.getNewAccessToken(request.getRefreshToken());
        return ResponseEntity.ok(tokens);
    }

    @PostMapping("logout")
    @SecurityRequirement(name = "JWT")
    public ResponseEntity<JwtResponse> logout(@RequestBody RefreshJwtRequest request) throws AuthException {
        authService.logout(request.getRefreshToken());
        return ResponseEntity.ok().build();
    }

    @PutMapping("forgot-password")
    public ResponseEntity<PasswordResetToken> forgotPassword(@RequestBody ForgotPasswordRequest request) throws AuthException {
        PasswordResetToken token = authService.forgotPassword(request);
        return ResponseEntity.ok(token);
    }
}
