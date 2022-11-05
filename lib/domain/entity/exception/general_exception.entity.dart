import './util/recoverable_exception.entity.dart';

class GeneralException extends RecoverableException {
  GeneralException({
    super.failureReason = 'Unknown exception occurred',
    super.recoverySuggestion = 'Please check your action and retry.',
    super.recoveryOptions = const ['Retry'],
    super.onLocalizedFailureReason,
    super.onLocalizedRecoverySuggestion,
    super.onLocalizedRecoveryOptions,
    super.domain = 'general',
    super.code,
  });
}
