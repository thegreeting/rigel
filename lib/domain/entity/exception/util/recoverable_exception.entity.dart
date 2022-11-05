import 'package:flutter/widgets.dart';

typedef ResolveLocalizedText = String Function(BuildContext context);
typedef ResolveLocalizedOptions = List<String> Function(BuildContext context);

class RecoverableException implements Exception {
  RecoverableException({
    required this.failureReason,
    required this.recoverySuggestion,
    this.recoveryOptions = const [],
    this.onLocalizedFailureReason,
    this.onLocalizedRecoverySuggestion,
    this.onLocalizedRecoveryOptions,
    this.domain = 'general',
    this.code = 0,
  });

  String get message => '$failureReason\n$recoverySuggestion';
  String localizedMessage(BuildContext context) =>
      '${localizedFailureReason(context)}\n${localizedRecoverySuggestion(context)}';

  /// A string containing the error domain.
  final String domain;

  /// The error code.
  final int code;

  /// A string containing the localized description of the error.
  String get localizedDescription => '$domain:$code';

  /// A string containing the localized explanation of the reason for the error.
  final String failureReason;
  ResolveLocalizedText? onLocalizedFailureReason;
  String localizedFailureReason(BuildContext context) =>
      onLocalizedFailureReason?.call(context) ?? failureReason;

  /// A string containing the localized recovery suggestion for the error.
  final String recoverySuggestion;
  ResolveLocalizedText? onLocalizedRecoverySuggestion;
  String localizedRecoverySuggestion(BuildContext context) =>
      onLocalizedRecoverySuggestion?.call(context) ?? recoverySuggestion;

  /// An array containing the localized titles of buttons appropriate for displaying in an alert panel.
  final List<String> recoveryOptions;
  ResolveLocalizedOptions? onLocalizedRecoveryOptions;
  List<String> localizedRecoveryOptions(BuildContext context) =>
      onLocalizedRecoveryOptions?.call(context) ?? recoveryOptions;

  @override
  String toString() => '$message, $localizedDescription';
}
