part of '../fluent.dart';

/// Represents a filter builder that is not valid yet.
///
/// Provides methods to create a [ReadyFilterBuilder].
class OnGoingFilterBuilder<T extends DartElement> {
  final Selector<T> _selector;
  final Filter<T>? _initialFilter;
  final _JoinType? _joinType;

  OnGoingFilterBuilder._({
    required Selector<T> selector,
    Filter<T>? initialFilter,
    _JoinType? joinType,
  })  : assert(
            (initialFilter == null && joinType == null) ||
                (initialFilter != null && joinType != null),
            'Only specifying initialFilter or joinType is not allowed, '
            'please provide or omit both parameters'),
        _selector = selector,
        _initialFilter = initialFilter,
        _joinType = joinType;

  ReadyFilterBuilder<T> call(Filter<T> filter) {
    return _createReadyBuilder(filter);
  }

  ReadyFilterBuilder<T> havePathMatching(String regExp) {
    return _createReadyBuilder(Filters.pathMatches(regExp));
  }

  ReadyFilterBuilder<T> haveNameStartingWith(String str) {
    return _createReadyBuilder(Filters.nameStartsWith(str));
  }

  ReadyFilterBuilder<T> haveNameEndingWith(String str) {
    return _createReadyBuilder(Filters.nameEndsWith(str));
  }

  ReadyFilterBuilder<T> areInsideFolder(String folder,
      {bool includeNested = true}) {
    return _createReadyBuilder(
        Filters.insideFolder(folder, includeNested: includeNested));
  }

  ReadyFilterBuilder<S> _createReadyBuilder<S extends DartElement>(
    Filter<S> filter,
  ) {
    return ReadyFilterBuilder._(
      _selector as Selector<S>,
      _joinFiltersIfNeeded(filter as Filter<T>) as Filter<S>,
    );
  }

  Filter<T> _joinFiltersIfNeeded(Filter<T> filter) {
    final initialFilter = _initialFilter;
    if (initialFilter == null) {
      return filter;
    }
    if (_joinType == _JoinType.AND) {
      return initialFilter.and(filter);
    } else if (_joinType == _JoinType.OR) {
      return initialFilter.or(filter);
    } else {
      // Should never reach this point, since initialFilter and joinType
      // are verified in the constructor
      throw Exception(
        'Could not join filters since initialFilter '
        'is not null but joinType is null',
      );
    }
  }
}

/// Represents a filter builder that is valid and ready to be used.
class ReadyFilterBuilder<T extends DartElement> {
  final Selector<T> _selector;
  final Filter<T> _filter;

  ReadyFilterBuilder._(this._selector, this._filter);

  OnGoingFilterBuilder<T> get and => OnGoingFilterBuilder._(
        selector: _selector,
        initialFilter: _filter,
        joinType: _JoinType.AND,
      );

  OnGoingFilterBuilder<T> get or => OnGoingFilterBuilder._(
        selector: _selector,
        initialFilter: _filter,
        joinType: _JoinType.OR,
      );

  OnGoingValidationBuilder<T> get should => OnGoingValidationBuilder._(
        selector: _selector,
        filter: _filter,
      );
}
