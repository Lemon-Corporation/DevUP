package ru.lemonade.UserService.security.util;

import io.jsonwebtoken.Claims;
import org.apache.commons.text.RandomStringGenerator;
import org.springframework.lang.NonNull;
import ru.lemonade.UserService.model.Role;
import ru.lemonade.UserService.security.jwt.JwtAuthentication;

import java.util.List;
import java.util.Map;

public class JwtUtil {
    public static JwtAuthentication generate(Claims claims) {
        final JwtAuthentication jwtAuthentication = new JwtAuthentication();
        jwtAuthentication.setId(claims.get("id", Long.class));
        jwtAuthentication.setEmail(claims.getSubject());
        jwtAuthentication.setRoles(getRoles(claims));
        return jwtAuthentication;
    }

    private static List<Role> getRoles(@NonNull Claims claims) {
        final List<Map<String, Object>> rolesData = claims.get("roles", List.class);
        return rolesData.stream()
                .map(roleMap -> {
                    Role role = new Role();
                    role.setId(((Number) roleMap.get("id")).intValue());
                    role.setTitle((String) roleMap.get("title"));
                    return role;
        })
                .toList();
    }

    public static String generateRandomToken(int length) {
        RandomStringGenerator generator = RandomStringGenerator.builder()
                .withinRange('0', 'z')
                .filteredBy(Character::isLetterOrDigit)
                .build();
        return generator.generate(length);
    }
}
