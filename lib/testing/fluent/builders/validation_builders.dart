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

  ReadyValidationBuilder<T> haveNameStartingWith(String str) {
    return ReadyValidationBuilder._(
      _selector,
      _filter,
      Validations.nameStartsWith(str),
    );
  }

  ReadyValidationBuilder<T> haveNameEndingWith(String str) {
    return ReadyValidationBuilder._(
      _selector,
      _filter,
      Validations.nameEndsWith(str),
    );
  }

  ReadyValidationBuilder<DartClass> implementClass<C>() {
    if (T is! DartClass) {
      throw _unsupportedElementTypeException<DartClass>('implementClass');
    }
    return ReadyValidationBuilder._(
      _selector as Selector<DartClass>,
      _filter as Filter<DartClass>,
      Validations.implementsClass<C>(),
    );
  }

  ReadyValidationBuilder<DartClass> extendClass<C>() {
    if (T is! DartClass) {
      throw _unsupportedElementTypeException<DartClass>('extendClass');
    }
    return ReadyValidationBuilder._(
      _selector as Selector<DartClass>,
      _filter as Filter<DartClass>,
      Validations.extendsClass<C>(),
    );
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
    return ReadyValidationBuilder._(
      _selector as Selector<DartLibrary>,
      _filter as Filter<DartLibrary>,
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
    return ReadyValidationBuilder._(
      _selector as Selector<DartLibrary>,
      _filter as Filter<DartLibrary>,
      Validations.onlyHaveDependenciesFromFolders(folders),
    );
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
        _selector,
        _filter,
        _validation,
      );
}
