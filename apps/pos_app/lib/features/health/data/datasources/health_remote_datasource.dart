import 'package:core/core.dart';
import '../models/health_model.dart';

abstract class HealthRemoteDataSource {
  Future<HealthModel> fetchHealth();
  Future<bool> ping();
}

class HealthRemoteDataSourceImpl implements HealthRemoteDataSource {
  final ApiClient apiClient;

  HealthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<HealthModel> fetchHealth() async {
    final response = await apiClient.get<Map<String, dynamic>>(ApiEndpoints.health);
    final rawData = response.data;
    if (rawData == null || rawData['data'] == null) {
      throw const ServerFailure(message: 'Malformed health response from server');
    }
    return HealthModel.fromJson(rawData['data'] as Map<String, dynamic>);
  }

  @override
  Future<bool> ping() async {
    final response = await apiClient.get<Map<String, dynamic>>(ApiEndpoints.healthPing);
    final rawData = response.data;
    if (rawData != null && rawData['data'] != null && rawData['data']['pong'] == true) {
      return true;
    }
    return false;
  }
}
