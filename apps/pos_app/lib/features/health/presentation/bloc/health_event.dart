import 'package:equatable/equatable.dart';

abstract class HealthEvent extends Equatable {
  const HealthEvent();

  @override
  List<Object?> get props => [];
}

class FetchHealthEvent extends HealthEvent {
  const FetchHealthEvent();
}

class PingServerEvent extends HealthEvent {
  const PingServerEvent();
}
