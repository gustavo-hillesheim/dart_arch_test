part of '../fluent.dart';

/// Represents a validation builder that is not valid yet.
///
/// Provides methods to create a [ReadyValidationBuilder].
class OnGoingValidationBuilder<T extends DartElement> {
  final Selector<T> _selector;
  final Filter<T> _filter;
  final Validation<T>? _initialValidation;
  final _JoinType? _joinType;

  OnGoingValidationBuilder._({
    required Selector<T> selector,
    required Filter<T> filter,
    Validation<T>? initialValidation,
    _JoinType? joinType,
  })  : assert(
            (initialValidation == null && joinType == null) ||
                (initialValidation != null && joinType != null),
            'Only specifying initialValidation or joinType is not allowed, '
            'please provide or omit both parameters'),
        _selector = selector,
        _filter = filter,
        _initialValidation = initialValidation,
        _joinType = joinType;

  ReadyValidationBuilder<T> call(Validation<T> validation) {
    return _createReadyBuilder(validation);
  }

  ReadyValidationBuilder<T> haveNameStartingWith(String str) {
    return _createReadyBuilder(Validations.nameStartsWith(str));
  }

  ReadyValidationBuilder<T> haveNameEndingWith(String str) {
    return _createReadyBuilder(Validations.nameEndsWith(str));
  }

  ReadyValidationBuilder<DartClass> implementClass<C>() {
    if (T is! DartClass) {
      throw _unsupportedElementTypeException<DartClass>('implementClass');
    }
    return _createReadyBuilder(Validations.implementsClass<C>());
  }

  ReadyValidationBuilder<DartClass> extendClass<C>() {
    if (T is! DartClass) {
      throw _unsupportedElementTypeException<DartClass>('extendClass');
    }
    return _createReadyBuilder(Validations.extendsClass<C>());
  }

  ReadyValidationBuilder<DartLibrary> noDependencyMatching(
    String regExp, {
    String? description,
  }) {
    if (T is! DartLibrary) {
      throw _unsupportedElementTypeException<DartLibrary>(
        'noDependencyMatching',
      );
    }
    return _createReadyBuilder(
      Validations.noDependencyMatches(regExp, description: description),
    );
  }

  ReadyValidationBuilder<DartLibrary> onlyHaveDependenciesFromFolders(
    List<String> folders,
  ) {
    if (T is! DartLibrary) {
      throw _unsupportedElementTypeException<DartLibrary>(
        'onlyHaveDependenciesFromFolders',
      );
    }
    return _createReadyBuilder(
      Validations.onlyHaveDependenciesFromFolders(folders),
    );
  }

  ReadyValidationBuilder<S> _createReadyBuilder<S extends DartElement>(
    Validation<S> validation,
  ) {
    return ReadyValidationBuilder._(
      _selector as Selector<S>,
      _filter as Filter<S>,
      _joinValidationsIfNeeded(validation as Validation<T>) as Validation<S>,
    );
  }

  Validation<T> _joinValidationsIfNeeded(Validation<T> validation) {
    final initialValidation = _initialValidation;
    if (initialValidation == null) {
      return validation;
    }
    if (_joinType == _JoinType.AND) {
      return initialValidation.and(validation);
    } else if (_joinType == _JoinType.OR) {
      return initialValidation.or(validation);
    } else {
      // Should never reach this point, since initialValidation and joinType
      // are verified in the constructor
      throw Exception(
        'Could not join validations since initialValidation '
        'is not null but joinType is null',
      );
    }
  }

  UnsupportedValidationException
      _unsupportedElementTypeException<S extends DartElement>(
    String validationName,
  ) {
    return UnsupportedValidationException(
      'Can not use "$validationName" validation on elements '
      'of type $T because they are not assignable to $S',
    );
  }
}

/// Represents a validation builder that is valid and ready to be used.
class ReadyValidationBuilder<T extends DartElement> extends ArchRule<T> {
  final Selector<T> _selector;
  final Filter<T> _filter;
  final Validation<T> _validation;

  ReadyValidationBuilder._(this._selector, this._filter, this._validation)
      : super(selector: _selector, filter: _filter, validation: _validation);

  OnGoingValidationBuilder get and => OnGoingValidationBuilder._(
        selector: _selector,
        filter: _filter,
        initialValidation: _validation,
        joinType: _JoinType.AND,
      );

  OnGoingValidationBuilder get or => OnGoingValidationBuilder._(
        selector: _selector,
        filter: _filter,
        initialValidation: _validation,
        joinType: _JoinType.OR,
      );
}
