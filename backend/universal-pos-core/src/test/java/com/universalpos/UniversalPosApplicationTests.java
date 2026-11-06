package com.universalpos;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest
@ActiveProfiles("test")
class UniversalPosApplicationTests {

    @Test
    void contextLoads() {
        // Verifies Spring ApplicationContext boots successfully with test configuration
    }
}
