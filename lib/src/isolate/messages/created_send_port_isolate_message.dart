part of '../isolate_channel.dart';

class CreatedSendPortIsolateMessage extends IsolateMessage {
  const CreatedSendPortIsolateMessage({required this.sendPort});

  factory CreatedSendPortIsolateMessage._fromMap(Map<String, dynamic> json) {
    return CreatedSendPortIsolateMessage(
      sendPort: json['sendPort'] as SendPort,
    );
  }

  final SendPort sendPort;

  @override
  Map<String, dynamic> _toMap() {
    return {
      '_type': 'CreatedSendPortIsolateMessage',
      'sendPort': sendPort,
    };
  }
}
