package com.myprj.prj.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
public class SecuNo extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.httpBasic().disable();
        // anonymous() :익명의 사용자의 접근을 허용
        http.authorizeRequests().anyRequest().permitAll();
        http.csrf().disable();
        // http.authorizeRequests().anyRequest().permitAll(); // Also doesn't work.
    }
}
