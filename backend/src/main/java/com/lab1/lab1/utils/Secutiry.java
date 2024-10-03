package com.lab1.lab1.utils;

import java.util.Base64;
import java.util.regex.Pattern;

import javax.xml.bind.DatatypeConverter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Secutiry {

    private static final Pattern PASSWORD_PATTERN = Pattern.compile(
            "^[a-zA-Z0-9!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]*$");

    private static final Pattern LOGIN_PATTERN = Pattern.compile(
            "^[a-zA-Z][a-zA-Z0-9_-]*$");

    public String getMd5Hash(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            var messageDigest = md.digest(password.getBytes(StandardCharsets.UTF_8));
            return DatatypeConverter.printHexBinary(messageDigest).toUpperCase();
        } catch(NoSuchAlgorithmException e) {
            return null;
        }
    }

    public boolean verifyPassword(String password, String md5) {
        return getMd5Hash(password).equals(md5);
    }

    public boolean isValidPassword(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }

        return PASSWORD_PATTERN.matcher(password).matches();
    }

    public boolean isValidLogin(String login) {
        if (login == null || login.length() < 4) {
            return false;
        }

        return LOGIN_PATTERN.matcher(login).matches();
    }

    public String generateToken(String login) {
        return Base64.getUrlEncoder().encodeToString((login + System.currentTimeMillis()).getBytes());
    }
}
