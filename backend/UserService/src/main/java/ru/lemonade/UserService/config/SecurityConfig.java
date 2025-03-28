package ru.lemonade.UserService.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import ru.lemonade.UserService.security.jwt.JwtFilter;
import ru.lemonade.UserService.service.security.LUserDetailsService;
import ru.lemonade.UserService.settings.ApiPath;

import java.util.List;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig {
    public static final String AUTH_MOBILE_CONTROLLER_PATH = ApiPath.AUTH_MOBILE_CONTROLLER_PATH;
    private final JwtFilter jwtFilter;

    public SecurityConfig(JwtFilter jwtFilter) {
        this.jwtFilter = jwtFilter;
    }

    @Bean
    public UserDetailsService userDetailsService() {
        return new LUserDetailsService();
    }
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        return http.csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(
                        session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )
                .authorizeHttpRequests(
                        auth -> auth
                                .requestMatchers(
                                        ApiPath.AUTH_MOBILE_CONTROLLER_PATH + "/login",
                                        ApiPath.AUTH_MOBILE_CONTROLLER_PATH + "/access",
                                        ApiPath.AUTH_MOBILE_CONTROLLER_PATH + "/refresh",
                                        ApiPath.AUTH_MOBILE_CONTROLLER_PATH + "/forgot-password",
                                        ApiPath.USER_CONTROLLER_PATH + "/create",
                                        ApiPath.USER_CONTROLLER_PATH + "/change-password",
                                        "/swagger-ui.html",
                                        "/swagger-ui/**",
                                        "/api/api-docs",
                                        "/api/api-docs/**"
                                ).permitAll()
                                .requestMatchers("/api/**").authenticated()
                                .anyRequest().permitAll()
                )
                .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class)
                .build();
    }
}
