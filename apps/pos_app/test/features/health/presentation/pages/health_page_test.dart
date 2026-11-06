import 'package:bloc_test/bloc_test.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pos_app/features/health/domain/entities/health_entity.dart';
import 'package:pos_app/features/health/presentation/bloc/health_bloc.dart';
import 'package:pos_app/features/health/presentation/bloc/health_event.dart';
import 'package:pos_app/features/health/presentation/bloc/health_state.dart';
import 'package:pos_app/features/health/presentation/pages/health_page.dart';

class MockHealthBloc extends MockBloc<HealthEvent, HealthState>
    implements HealthBloc {}

void main() {
  late MockHealthBloc mockHealthBloc;

  setUp(() {
    mockHealthBloc = MockHealthBloc();
  });

  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: BlocProvider<HealthBloc>.value(
        value: mockHealthBloc,
        child: child,
      ),
    );
  }

  testWidgets('displays CircularProgressIndicator when state is HealthLoading',
      (tester) async {
    when(() => mockHealthBloc.state).thenReturn(const HealthLoading());

    await tester.pumpWidget(buildTestableWidget(const HealthPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Querying Universal POS backend...'), findsOneWidget);
  });

  testWidgets('displays error message and retry button when state is HealthError',
      (tester) async {
    when(() => mockHealthBloc.state).thenReturn(
      const HealthError(message: 'Server unreachable at localhost:8080'),
    );

    await tester.pumpWidget(buildTestableWidget(const HealthPage()));

    expect(find.text('Backend Connection Failed'), findsOneWidget);
    expect(find.text('Server unreachable at localhost:8080'), findsOneWidget);
    expect(find.text('Retry Connection'), findsOneWidget);
  });

  testWidgets('displays system health details when state is HealthLoaded',
      (tester) async {
    final tHealth = HealthEntity(
      status: 'UP',
      databaseStatus: 'UP',
      databaseProduct: 'PostgreSQL 16.0',
      version: '1.0.0-phase1',
      environment: 'dev',
      timestamp: DateTime.parse('2026-11-06T05:30:00Z'),
      uptimeMillis: 45000,
      details: const {},
    );

    when(() => mockHealthBloc.state).thenReturn(
      HealthLoaded(health: tHealth, pingLatencyMs: 14),
    );

    await tester.pumpWidget(buildTestableWidget(const HealthPage()));

    expect(find.text('Spring Boot Modular Monolith'), findsOneWidget);
    expect(find.text('PostgreSQL 16.0'), findsOneWidget);
    expect(find.text('1.0.0-phase1'), findsOneWidget);
    expect(find.text('Real-Time Heartbeat Probe'), findsOneWidget);
    expect(find.text('Round-trip latency: 14ms'), findsOneWidget);
  });
}
