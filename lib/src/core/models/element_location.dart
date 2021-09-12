import 'package:equatable/equatable.dart';

class ElementLocation extends Equatable {
  final String uri;
  final int column;
  final int row;

  ElementLocation({required this.uri, required this.column, required this.row});

  @override
  List<Object?> get props => [uri, column, row];
}
