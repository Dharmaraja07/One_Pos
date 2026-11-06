class ApiEndpoints {
  ApiEndpoints._();

  static const String defaultBaseUrl = 'http://localhost:8080/api/v1';

  // Health
  static const String health = '/health';
  static const String healthPing = '/health/ping';
}
