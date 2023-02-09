import 'package:equatable/equatable.dart';

class DartMetadata extends Equatable {
  final dynamic metadata;

  const DartMetadata({required this.metadata});

  @override
  List<Object?> get props => [metadata];

  @override
  String toString() {
    return 'DartMetadata(metadata: "$metadata")';
  }
}
