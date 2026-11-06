import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_health_usecase.dart';
import '../../domain/usecases/ping_usecase.dart';
import 'health_event.dart';
import 'health_state.dart';

class HealthBloc extends Bloc<HealthEvent, HealthState> {
  final GetHealthUseCase getHealthUseCase;
  final PingUseCase pingUseCase;

  HealthBloc({
    required this.getHealthUseCase,
    required this.pingUseCase,
  }) : super(const HealthInitial()) {
    on<FetchHealthEvent>(_onFetchHealth);
    on<PingServerEvent>(_onPingServer);
  }

  Future<void> _onFetchHealth(
    FetchHealthEvent event,
    Emitter<HealthState> emit,
  ) async {
    emit(const HealthLoading());
    try {
      final stopwatch = Stopwatch()..start();
      final health = await getHealthUseCase();
      stopwatch.stop();

      emit(HealthLoaded(
        health: health,
        isPingHealthy: true,
        pingLatencyMs: stopwatch.elapsedMilliseconds,
      ));
    } catch (e) {
      emit(HealthError(message: e.toString()));
    }
  }

  Future<void> _onPingServer(
    PingServerEvent event,
    Emitter<HealthState> emit,
  ) async {
    if (state is HealthLoaded) {
      final current = state as HealthLoaded;
      final stopwatch = Stopwatch()..start();
      final pong = await pingUseCase();
      stopwatch.stop();

      emit(current.copyWith(
        isPingHealthy: pong,
        pingLatencyMs: stopwatch.elapsedMilliseconds,
      ));
    }
  }
}
