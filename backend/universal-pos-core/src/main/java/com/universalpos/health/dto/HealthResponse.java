package com.universalpos.health.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.Map;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class HealthResponse {

    private String status;
    private String databaseStatus;
    private String databaseProduct;
    private String version;
    private String environment;
    private Instant timestamp;
    private long uptimeMillis;
    private Map<String, Object> details;
}
