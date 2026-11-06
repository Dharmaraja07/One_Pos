package com.universalpos.health.api;

import com.universalpos.health.dto.HealthResponse;
import com.universalpos.health.service.HealthService;
import com.universalpos.shared.dto.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/health")
@Tag(name = "Health & Diagnostics", description = "System health, database probe, and platform heartbeat")
public class HealthController {

    private final HealthService healthService;

    public HealthController(HealthService healthService) {
        this.healthService = healthService;
    }

    @GetMapping
    @Operation(summary = "Get system health status", description = "Verifies application uptime, active profile, and database connectivity")
    public ResponseEntity<ApiResponse<HealthResponse>> getHealth() {
        HealthResponse response = healthService.checkHealth();
        return ResponseEntity.ok(ApiResponse.ok(response, "System health retrieved successfully"));
    }

    @GetMapping("/ping")
    @Operation(summary = "Fast connectivity ping", description = "Lightweight ping endpoint for client network heartbeat")
    public ResponseEntity<ApiResponse<Map<String, Object>>> ping() {
        return ResponseEntity.ok(ApiResponse.ok(
                Map.of(
                        "pong", true,
                        "timestamp", Instant.now().toString()
                ),
                "Heartbeat acknowledged"
        ));
    }
}
