package com.universalpos.health.service;

import com.universalpos.health.dto.HealthResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.lang.management.ManagementFactory;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

@Service
public class HealthService {

    private static final Logger log = LoggerFactory.getLogger(HealthService.class);

    private final DataSource dataSource;
    private final String environment;
    private final long startTime;

    public HealthService(
            DataSource dataSource,
            @Value("${spring.profiles.active:dev}") String environment) {
        this.dataSource = dataSource;
        this.environment = environment;
        this.startTime = ManagementFactory.getRuntimeMXBean().getStartTime();
    }

    public HealthResponse checkHealth() {
        String dbStatus = "DOWN";
        String dbProduct = "UNKNOWN";
        Map<String, Object> details = new HashMap<>();

        try (Connection conn = dataSource.getConnection()) {
            if (conn.isValid(2)) {
                dbStatus = "UP";
                DatabaseMetaData metaData = conn.getMetaData();
                dbProduct = metaData.getDatabaseProductName() + " " + metaData.getDatabaseProductVersion();
                details.put("databaseUrl", metaData.getURL());
                details.put("driverName", metaData.getDriverName());
            }
        } catch (Exception e) {
            log.warn("Health check database probe failed: {}", e.getMessage());
            details.put("databaseError", e.getMessage());
        }

        String overallStatus = "UP".equals(dbStatus) ? "UP" : "DEGRADED";
        long uptime = System.currentTimeMillis() - startTime;

        details.put("activeThreads", Thread.activeCount());
        details.put("javaVersion", System.getProperty("java.version"));

        return HealthResponse.builder()
                .status(overallStatus)
                .databaseStatus(dbStatus)
                .databaseProduct(dbProduct)
                .version("1.0.0-phase1")
                .environment(environment)
                .timestamp(Instant.now())
                .uptimeMillis(uptime)
                .details(details)
                .build();
    }
}
