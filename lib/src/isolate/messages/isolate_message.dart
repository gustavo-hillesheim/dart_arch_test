part of '../isolate_channel.dart';

sealed class IsolateMessage {
  const IsolateMessage();

  factory IsolateMessage._fromMap(Map<String, dynamic> json) {
    switch (json['_type'] as String) {
      case 'CreatedSendPortIsolateMessage':
        return CreatedSendPortIsolateMessage._fromMap(json);
      case 'PrintIsolateMessage':
        return PrintIsolateMessage._fromMap(json);
      case 'ProcessFinishedIsolateMessage':
        return ProcessFinishedIsolateMessage._fromMap(json);
      default:
        throw UnimplementedError(
          'Unknown IsolateMessage type: ${json['_type']}',
        );
    }
  }

  Map<String, dynamic> _toMap();
}
