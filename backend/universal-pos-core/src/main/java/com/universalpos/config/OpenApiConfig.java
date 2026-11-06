package com.universalpos.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
            .info(new Info()
                .title("Universal POS API")
                .version("1.0.0-phase1")
                .description("Enterprise Multi-Tenant Offline-First Point of Sale Core API")
                .contact(new Contact().name("Universal POS Engineering Team"))
                .license(new License().name("Proprietary Commercial")));
    }
}
