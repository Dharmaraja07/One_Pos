import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Unable to connect to server. Please verify network connectivity.',
    super.code = 'NETWORK_UNAVAILABLE',
  });
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Authentication required or session expired.',
    super.code = 'UNAUTHORIZED',
  });
}
