import './util/recoverable_exception.entity.dart';

class UserActivityException extends RecoverableException {
  UserActivityException({
    super.failureReason = 'UserActivity exception occurred',
    super.recoverySuggestion = 'Please check your action and retry.',
    super.recoveryOptions = const ['Retry'],
    super.onLocalizedFailureReason,
    super.onLocalizedRecoverySuggestion,
    super.onLocalizedRecoveryOptions,
    super.domain = 'user_activity',
    super.code,
  });
}

class NeedToAuthenticate extends UserActivityException {
  NeedToAuthenticate()
      : super(
          failureReason: 'Need to authenticate',
          recoverySuggestion:
              'If you new to this app, please Connect your wallet to continue.',
          recoveryOptions: const ['Connect wallet'],
          code: 1,
        );
}
