-- Universal POS — Phase 1 Initial Baseline Migration
-- Establishes database extensions and system metadata verification table.

-- Enable UUID extension if supported
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- System metadata table for platform diagnostics and heartbeat tracking
CREATE TABLE IF NOT EXISTS system_metadata (
    id VARCHAR(64) PRIMARY KEY,
    key_name VARCHAR(128) NOT NULL UNIQUE,
    value_text TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Seed baseline platform descriptor
INSERT INTO system_metadata (id, key_name, value_text)
VALUES ('SYS_BASELINE_001', 'PLATFORM_VERSION', '1.0.0-phase1-foundation')
ON CONFLICT (key_name) DO NOTHING;
