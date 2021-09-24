part of '../fluent.dart';

/// Represents a validation builder that is not valid yet.
///
/// Provides methods to create a [ReadyValidationBuilder].
class OnGoingValidationBuilder<T extends DartElement> {
  final Selector<T> _selector;
  final Filter<T> _filter;
  final Validation<T>? _initialValidation;

  OnGoingValidationBuilder._(
    this._selector,
    this._filter, [
    this._initialValidation,
  ]);

  ReadyValidationBuilder<T> call(Validation<T> validation) {
    final initialValidation = _initialValidation;
    if (initialValidation != null) {
      return ReadyValidationBuilder._(
        _selector,
        _filter,
        initialValidation.and(validation),
      );
    }
    return ReadyValidationBuilder._(_selector, _filter, validation);
  }
}

/// Represents a validation builder that is valid and ready to be used.
class ReadyValidationBuilder<T extends DartElement> {
  final Selector<T> _selector;
  final Filter<T> _filter;
  final Validation<T> _validation;

  ReadyValidationBuilder._(this._selector, this._filter, this._validation);

  OnGoingValidationBuilder get and => OnGoingValidationBuilder._(
        _selector,
        _filter,
        _validation,
      );
}
