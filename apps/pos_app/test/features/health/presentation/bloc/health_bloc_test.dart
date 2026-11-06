import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pos_app/features/health/domain/entities/health_entity.dart';
import 'package:pos_app/features/health/domain/usecases/get_health_usecase.dart';
import 'package:pos_app/features/health/domain/usecases/ping_usecase.dart';
import 'package:pos_app/features/health/presentation/bloc/health_bloc.dart';
import 'package:pos_app/features/health/presentation/bloc/health_event.dart';
import 'package:pos_app/features/health/presentation/bloc/health_state.dart';

class MockGetHealthUseCase extends Mock implements GetHealthUseCase {}
class MockPingUseCase extends Mock implements PingUseCase {}

void main() {
  late MockGetHealthUseCase mockGetHealthUseCase;
  late MockPingUseCase mockPingUseCase;
  late HealthBloc healthBloc;

  setUp(() {
    mockGetHealthUseCase = MockGetHealthUseCase();
    mockPingUseCase = MockPingUseCase();
    healthBloc = HealthBloc(
      getHealthUseCase: mockGetHealthUseCase,
      pingUseCase: mockPingUseCase,
    );
  });

  tearDown(() {
    healthBloc.close();
  });

  final tHealth = HealthEntity(
    status: 'UP',
    databaseStatus: 'UP',
    databaseProduct: 'PostgreSQL 16.0',
    version: '1.0.0-phase1',
    environment: 'test',
    timestamp: DateTime.parse('2026-11-06T05:30:00Z'),
    uptimeMillis: 15000,
    details: const {'activeThreads': 4},
  );

  test('initial state should be HealthInitial', () {
    expect(healthBloc.state, equals(const HealthInitial()));
  });

  blocTest<HealthBloc, HealthState>(
    'emits [HealthLoading, HealthLoaded] when FetchHealthEvent is added successfully',
    build: () {
      when(() => mockGetHealthUseCase()).thenAnswer((_) async => tHealth);
      return healthBloc;
    },
    act: (bloc) => bloc.add(const FetchHealthEvent()),
    expect: () => [
      const HealthLoading(),
      isA<HealthLoaded>()
          .having((s) => s.health.status, 'status', 'UP')
          .having((s) => s.isPingHealthy, 'isPingHealthy', true),
    ],
    verify: (_) {
      verify(() => mockGetHealthUseCase()).called(1);
    },
  );

  blocTest<HealthBloc, HealthState>(
    'emits [HealthLoading, HealthError] when FetchHealthEvent throws failure',
    build: () {
      when(() => mockGetHealthUseCase())
          .thenThrow(const ServerFailure(message: 'Connection refused'));
      return healthBloc;
    },
    act: (bloc) => bloc.add(const FetchHealthEvent()),
    expect: () => [
      const HealthLoading(),
      isA<HealthError>(),
    ],
  );
}
