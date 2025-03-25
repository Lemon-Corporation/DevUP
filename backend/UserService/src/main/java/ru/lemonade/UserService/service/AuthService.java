package ru.lemonade.UserService.service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwt;
import jakarta.security.auth.message.AuthException;
import org.springframework.lang.NonNull;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import ru.lemonade.UserService.error.exception.InvalidTokenException;
import ru.lemonade.UserService.model.PasswordResetToken;
import ru.lemonade.UserService.repository.PasswordResetTokenRepository;
import ru.lemonade.UserService.request.AuthRequest;
import ru.lemonade.UserService.request.ForgotPasswordRequest;
import ru.lemonade.UserService.response.JwtAccessResponse;
import ru.lemonade.UserService.response.JwtRefreshResponse;
import ru.lemonade.UserService.response.JwtResponse;
import ru.lemonade.UserService.security.jwt.JwtProvider;
import ru.lemonade.UserService.security.LUserDetails;
import ru.lemonade.UserService.security.util.JwtUtil;
import ru.lemonade.UserService.security.util.RefreshStorage;
import ru.lemonade.UserService.service.security.LUserDetailsService;
import ru.lemonade.UserService.settings.Constants;

@Service
public class AuthService {
    private final LUserDetailsService userDetailsService;
    private final RefreshStorage refreshStorage;
    private final JwtProvider jwtProvider;
    private final PasswordEncoder passwordEncoder;
    private final PasswordResetTokenRepository passwordResetTokenRepository;

    public AuthService(LUserDetailsService lUserDetailsService, RefreshStorage refreshStorage,
                       JwtProvider jwtProvider, PasswordEncoder passwordEncoder, PasswordResetTokenRepository passwordResetTokenRepository) {
        this.userDetailsService = lUserDetailsService;
        this.refreshStorage = refreshStorage;
        this.jwtProvider = jwtProvider;
        this.passwordEncoder = passwordEncoder;
        this.passwordResetTokenRepository = passwordResetTokenRepository;
    }

    public JwtResponse login(@NonNull AuthRequest authRequest) throws AuthException {

        final LUserDetails userDetails = (LUserDetails) userDetailsService.loadUserByUsername(authRequest.getUsername());

        if (!userDetails.isEnabled()) {
            refreshStorage.banToken(userDetails.getUsername());
            throw new DisabledException("User is disabled");
        }
        if (passwordEncoder.matches(authRequest.getPassword(), userDetails.getPassword())) {
            final String accessToken = jwtProvider.generateAccessToken(userDetails);
            final String refreshToken = jwtProvider.generateRefreshToken(userDetails);
            refreshStorage.put(userDetails.getUsername(), refreshToken);
            return new JwtResponse(accessToken, refreshToken);
        } else {
            throw new AuthException("Wrong password");
        }
    }

    public JwtResponse getNewAccessToken(@NonNull String refreshToken) throws AuthException {
        if (jwtProvider.validateRefreshToken(refreshToken)) {
            final Claims claims = jwtProvider.getRefreshClaims(refreshToken);
            final String username = claims.getSubject();
            String savedRefreshToken = refreshStorage.get(username);
            if (savedRefreshToken.equals(refreshToken) && refreshStorage.isNotInBlackList(username)) {
                LUserDetails userDetails = (LUserDetails) userDetailsService.loadUserByUsername(username);
                String newAccessToken = jwtProvider.generateAccessToken(userDetails);
                String newRefreshToken = jwtProvider.generateRefreshToken(userDetails);
                JwtResponse response = new JwtResponse();
                response.setAccessToken(newAccessToken);
                response.setRefreshToken(newRefreshToken);
                refreshStorage.put(username, newRefreshToken);
                return response;
            }
        }
        throw new AuthException("wrong refresh token");
    }

    public void logout(@NonNull String refreshToken) throws AuthException {
        if (jwtProvider.validateRefreshToken(refreshToken)) {
            Claims claims = jwtProvider.getRefreshClaims(refreshToken);
            String username = claims.getSubject();
            String savedRefreshToken = refreshStorage.get(username);
            if (savedRefreshToken.equals(refreshToken) && refreshStorage.isNotInBlackList(username)) {
                refreshStorage.banToken(username);
                return;
            }
        }
        throw new InvalidTokenException("wrong refresh token");
    }

    public PasswordResetToken forgotPassword(@NonNull ForgotPasswordRequest forgotPasswordRequest) throws AuthException {
        LUserDetails userDetails = (LUserDetails) userDetailsService.loadUserByEmail(forgotPasswordRequest.getEmail());
        if (!userDetails.isEnabled()) {
            refreshStorage.banToken(userDetails.getUsername());
            throw new DisabledException("User is disabled");
        }

        String token = JwtUtil.generateRandomToken(Constants.resetPasswordsTokenLength);
        PasswordResetToken resetToken = new PasswordResetToken(
                userDetails.getId(),
                token,
                Constants.resetPasswordsTokenSeconds
        );

        passwordResetTokenRepository.save(resetToken);
        // to do: добавить отправку уведомления в kafka и отправке письма со ссылкой пользователю и убрать возврат токена
        return resetToken;
    }
}


