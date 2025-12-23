part of '../isolate_channel.dart';

class ProcessFinishedIsolateMessage extends IsolateMessage {
  const ProcessFinishedIsolateMessage();

  factory ProcessFinishedIsolateMessage._fromMap(Map<String, dynamic> json) {
    return const ProcessFinishedIsolateMessage();
  }

  @override
  Map<String, dynamic> _toMap() {
    return {
      '_type': 'ProcessFinishedIsolateMessage',
    };
  }
}
