import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../di/service_locator.dart';
import '../features/health/presentation/bloc/health_bloc.dart';
import '../features/health/presentation/bloc/health_event.dart';
import '../features/health/presentation/pages/health_page.dart';

class AppRouter {
  AppRouter._();

  static const String initialRoute = '/';

  static final GoRouter router = GoRouter(
    initialLocation: initialRoute,
    routes: [
      GoRoute(
        path: '/',
        name: 'health',
        builder: (context, state) => BlocProvider<HealthBloc>(
          create: (context) => sl<HealthBloc>()..add(const FetchHealthEvent()),
          child: const HealthPage(),
        ),
      ),
    ],
  );
}
