package com.lab1.lab1;

import com.lab1.lab1.service.PasswordEncoderService;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class Md5HashGeneratorTests {

    @Test
    void md5HashTest() {
        var password = "Hello, World!";
        var passwordHash = new PasswordEncoderService().getMd5Hash(password);
        System.out.println(password);
    }
}
