part of '../fluent.dart';

/// Represents a filter builder that is not valid yet.
///
/// Provides methods to create a [ReadyFilterBuilder].
class OnGoingFilterBuilder<T extends DartElement> {
  final Selector<T> _selector;
  final Filter<T>? _initialFilter;

  OnGoingFilterBuilder._(this._selector, [this._initialFilter]);

  ReadyFilterBuilder<T> call(Filter<T> filter) {
    final initialFilter = _initialFilter;
    if (initialFilter != null) {
      return ReadyFilterBuilder(_selector, initialFilter.and(filter));
    }
    return ReadyFilterBuilder(_selector, filter);
  }
}

/// Represents a filter builder that is valid and ready to be used.
class ReadyFilterBuilder<T extends DartElement> {
  final Selector<T> _selector;
  final Filter<T> _filter;

  ReadyFilterBuilder(this._selector, this._filter);

  OnGoingFilterBuilder<T> get and => OnGoingFilterBuilder._(_selector, _filter);

  OnGoingValidationBuilder<T> get should => OnGoingValidationBuilder._(
        _selector,
        _filter,
      );
}
