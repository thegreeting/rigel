import './util/recoverable_exception.entity.dart';

class NetworkException extends RecoverableException {
  NetworkException({
    super.failureReason = 'Network exception occurred',
    super.recoverySuggestion = 'Please check your network connection and retry.',
    super.recoveryOptions = const ['Retry'],
    super.onLocalizedFailureReason,
    super.onLocalizedRecoverySuggestion,
    super.onLocalizedRecoveryOptions,
    super.domain = 'network',
    super.code,
  });
}

class NotFound extends NetworkException {
  NotFound()
      : super(
          failureReason: 'Not found',
          recoverySuggestion: 'It may be deleted.',
          recoveryOptions: const ['Retry'],
          code: 404,
        );
}

class ServerError extends NetworkException {
  ServerError()
      : super(
          failureReason: 'Server error',
          recoverySuggestion: 'Please retry later or contact the admin.',
          recoveryOptions: const ['Retry'],
          code: 500,
        );
}

class ServerNotReady extends NetworkException {
  ServerNotReady()
      : super(
          failureReason: 'Site is under maintenance.',
          recoverySuggestion: 'Please check the info from admin and retry later.',
          recoveryOptions: const ['Retry'],
          code: 503,
        );
}
