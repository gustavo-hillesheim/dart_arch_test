part of '../isolate_channel.dart';

class PrintIsolateMessage extends IsolateMessage {
  const PrintIsolateMessage({required this.message});

  factory PrintIsolateMessage._fromMap(Map<String, dynamic> json) {
    return PrintIsolateMessage(
      message: json['message'] as String,
    );
  }

  final String message;

  @override
  Map<String, dynamic> _toMap() {
    return {
      '_type': 'PrintIsolateMessage',
      'message': message,
    };
  }
}
