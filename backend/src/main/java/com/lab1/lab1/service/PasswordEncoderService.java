package com.lab1.lab1.service;

import javax.xml.bind.DatatypeConverter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordEncoderService {
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
}
