package com.universalpos.health.api;

import com.universalpos.health.dto.HealthResponse;
import com.universalpos.health.service.HealthService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;

import java.time.Instant;
import java.util.Map;

import static org.mockito.BDDMockito.given;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
class HealthControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private HealthService healthService;

    @Test
    @DisplayName("GET /api/v1/health returns 200 OK with UP status")
    void getHealth_shouldReturnSystemHealth() throws Exception {
        HealthResponse mockResponse = HealthResponse.builder()
                .status("UP")
                .databaseStatus("UP")
                .databaseProduct("PostgreSQL 16.0")
                .version("1.0.0-phase1")
                .environment("test")
                .timestamp(Instant.now())
                .uptimeMillis(12000)
                .details(Map.of("activeThreads", 4))
                .build();

        given(healthService.checkHealth()).willReturn(mockResponse);

        mockMvc.perform(get("/api/v1/health")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.status").value("UP"))
                .andExpect(jsonPath("$.data.databaseStatus").value("UP"))
                .andExpect(jsonPath("$.data.version").value("1.0.0-phase1"));
    }

    @Test
    @DisplayName("GET /api/v1/health/ping returns fast pong heartbeat")
    void ping_shouldReturnPong() throws Exception {
        mockMvc.perform(get("/api/v1/health/ping")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.pong").value(true))
                .andExpect(jsonPath("$.data.timestamp").isNotEmpty());
    }
}
