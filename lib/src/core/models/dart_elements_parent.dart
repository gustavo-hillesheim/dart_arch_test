import '../components/dart_element_finder.dart';
import 'dart_element.dart';

/// Abstract class for DartElements that have children that are "queriable".
/// A queriable element is an element that have a known location and name,
/// so only packages, libraries, types, methods and variables are considered queriables.
///
/// If the method [children] returns instances that are not queriable, for instance,
/// parameters and library dependencies, queries made by [DartElementFinder] that rely
/// on the location of the element would return incorrect result, since all of these
/// elements have an unknown location.
abstract class DartElementsParent<E extends DartElement> {
  /// This method should return all queriable elements that are declared inside
  /// of this element, considering that a queriable element is an element that have
  /// a known location and a name.
  List<E> get children;
}
