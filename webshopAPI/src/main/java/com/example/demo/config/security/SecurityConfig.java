package com.example.demo.config.security;

import com.example.demo.config.security.JWT.JWTGeneratorFilter;
import com.example.demo.config.security.JWT.JWTValidatorFilter;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.authentication.password.CompromisedPasswordChecker;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.argon2.Argon2PasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.password.HaveIBeenPwnedRestApiPasswordChecker;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(jsr250Enabled = true)
@RequiredArgsConstructor
public class SecurityConfig {

    private final JWTGeneratorFilter jwtGeneratorFilter;
    private final JWTValidatorFilter jwtValidatorFilter;
    private final UserSetter userSetter;

    @Bean
    @Profile("prod")
    SecurityFilterChain defaultSecurityFilterChain(HttpSecurity http) throws Exception {
        http
                .cors(corsCustomizer -> corsCustomizer.configurationSource(new CorsConfigurationSource() {
                    @Override
                    public CorsConfiguration getCorsConfiguration(HttpServletRequest request) {
                        CorsConfiguration config = new CorsConfiguration();
                        config.setAllowedOrigins(Collections.singletonList("http://localhost:4200"));
                        config.setAllowedMethods(Collections.singletonList("*"));
                        config.setAllowCredentials(true);
                        config.setAllowedHeaders(List.of("*"));
                        config.setExposedHeaders(Arrays.asList("Authorization", "refreshToken", "Bearer ", "TotalPage"));
                        config.setMaxAge(3600L);
                        return config;
                    }
                }))
                .authorizeHttpRequests((requests) -> requests
                        .requestMatchers(HttpMethod.GET, "/author").permitAll()
                        .requestMatchers(HttpMethod.POST, "/author").hasRole("admin")
                        .requestMatchers(HttpMethod.DELETE, "/author/*").hasRole("admin")
                        .requestMatchers(HttpMethod.PUT, "/author").hasRole("admin")
                        .requestMatchers(HttpMethod.GET, "/basket/user/*").authenticated()
                        .requestMatchers("/basket/book").authenticated()
                        .requestMatchers(HttpMethod.PATCH, "/basket/*").authenticated()
                        .requestMatchers(HttpMethod.POST, "/basket/*").authenticated()
                        .requestMatchers(HttpMethod.DELETE, "/basket/*/clear").authenticated()
                        .requestMatchers(HttpMethod.GET, "/book/*").permitAll()
                        .requestMatchers("/book/author/*", "/book/genre/*", "/book/publisher/*", "/book/successfully").permitAll()
                        .requestMatchers(HttpMethod.GET, "/book").permitAll()
                        .requestMatchers(HttpMethod.POST, "/book").hasRole("admin")
                        .requestMatchers(HttpMethod.PUT, "/book").hasRole("admin")
                        .requestMatchers("/book/*/coverImg").hasRole("admin")
                        .requestMatchers(HttpMethod.DELETE, "/book/*").hasRole("admin")
                        .requestMatchers(HttpMethod.GET, "/genre").permitAll()
                        .requestMatchers(HttpMethod.PUT, "/genre").hasRole("admin")
                        .requestMatchers(HttpMethod.POST, "/genre").hasRole("admin")
                        .requestMatchers(HttpMethod.DELETE, "/genre/*").hasRole("admin")
                        .requestMatchers(HttpMethod.GET, "/genre/*").permitAll()
                        .requestMatchers(HttpMethod.GET, "/order/user/*").authenticated()
                        .requestMatchers(HttpMethod.DELETE, "/order/cancel/*").authenticated()
                        .requestMatchers(HttpMethod.GET, "/order").hasRole("admin")
                        .requestMatchers(HttpMethod.POST, "/order/*").authenticated()
                        .requestMatchers("/paymentMethods", "/addressType").authenticated()
                        .requestMatchers("/publisher").permitAll()
                        .requestMatchers(HttpMethod.DELETE, "/publisher/*").hasRole("admin")
                        .requestMatchers(HttpMethod.GET, "/publisher/*").permitAll()
                        .requestMatchers("/review", "/review/**").authenticated()
                        .requestMatchers("/user/login", "/user/register").permitAll()
                        .requestMatchers(HttpMethod.PUT, "/user/*").authenticated()
                        .requestMatchers(HttpMethod.DELETE, "/user/*").authenticated()
                        .requestMatchers("/user/pfp/*").authenticated()
                        .requestMatchers("/coverImg/**", "/pfp/**").permitAll()
                        .requestMatchers("/user/vCode", "/user/check", "/password").permitAll()
                )
                .authenticationProvider(authProvider())
                .addFilterAfter(jwtGeneratorFilter, BasicAuthenticationFilter.class)
                .addFilterBefore(jwtValidatorFilter, BasicAuthenticationFilter.class)
                .formLogin(f -> f.disable())
                .csrf(crs -> crs.disable())
                .httpBasic(Customizer.withDefaults());

        return http.build();
    }

    @Bean
    @Profile("dev")
    SecurityFilterChain devSecurityFilterChain(HttpSecurity http) throws Exception {
        http
                .cors(corsCustomizer -> corsCustomizer.configurationSource(new CorsConfigurationSource() {
                    @Override
                    public CorsConfiguration getCorsConfiguration(HttpServletRequest request) {
                        CorsConfiguration config = new CorsConfiguration();
                        config.setAllowedOrigins(Collections.singletonList("http://localhost:4200"));
                        config.setAllowedMethods(Collections.singletonList("*"));
                        config.setAllowCredentials(true);
                        config.setAllowedHeaders(Collections.singletonList("*"));
                        config.setExposedHeaders(Arrays.asList("Authorization", "refreshToken", "Bearer ", "TotalPage"));
                        config.setMaxAge(3600L);
                        return config;
                    }
                }))
                .authorizeHttpRequests((requests) ->
                        requests.anyRequest().permitAll()
                )
                .formLogin(Customizer.withDefaults())
                .csrf(crs -> crs.disable())
                .httpBasic(Customizer.withDefaults());

        return http.build();
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return new Argon2PasswordEncoder(16, 32, 1, 1 << 12, 3);
    }

    @Bean
    public CompromisedPasswordChecker compromisedPasswordChecker() {
        return new HaveIBeenPwnedRestApiPasswordChecker();
    }

    @Bean
    @Profile("prod")
    AuthenticationProvider authProvider() {
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider(userSetter);
        authenticationProvider.setPasswordEncoder(passwordEncoder());

        return authenticationProvider;
    }
}
