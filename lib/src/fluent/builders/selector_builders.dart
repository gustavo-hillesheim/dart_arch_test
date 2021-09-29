part of '../fluent.dart';

/// Represents a selector builder that is valid and ready to be used.
///
/// Provides methods to create a [OnGoingFilterBuilder] or [OnGoingValidationBuilder].
class ReadySelectorBuilder<T extends DartElement> {
  final Selector<T> _selector;

  ReadySelectorBuilder._(this._selector);

  OnGoingFilterBuilder<T> get that =>
      OnGoingFilterBuilder._(selector: _selector);

  OnGoingValidationBuilder<T> get should => OnGoingValidationBuilder._(
        selector: _selector,
        filter: Filters.id(),
      );
}
