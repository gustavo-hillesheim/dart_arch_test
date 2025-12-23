import 'dart:async';
import 'dart:isolate';

part 'messages/isolate_message.dart';
part 'messages/created_send_port_isolate_message.dart';
part 'messages/print_isolate_message.dart';
part 'messages/process_finished_isolate_message.dart';

class IsolateChannel {
  IsolateChannel() {
    _subscription = _receivePort.listen(_messageListener);
  }

  factory IsolateChannel.fromSendPort(SendPort sendPort) {
    final channel = IsolateChannel();
    channel._clientSendPort = sendPort;
    channel.send(CreatedSendPortIsolateMessage(sendPort: channel.sendPort));
    return channel;
  }

  final _receivePort = ReceivePort();
  late StreamSubscription _subscription;
  final _messagesStreamController = StreamController<IsolateMessage>();
  SendPort? _clientSendPort;

  SendPort get sendPort => _receivePort.sendPort;

  Stream<IsolateMessage> get messages => _messagesStreamController.stream;

  void close() {
    _subscription.cancel();
    _receivePort.close();
    _messagesStreamController.close();
  }

  void _messageListener(dynamic message) {
    if (message is! Map<String, dynamic>) {
      throw ArgumentError(
        'Expected message to be of type Map<String, dynamic>, '
        'but got ${message.runtimeType}',
      );
    }
    final isolateMessage = IsolateMessage._fromMap(message);
    if (isolateMessage is CreatedSendPortIsolateMessage) {
      _clientSendPort = isolateMessage.sendPort;
    } else {
      _messagesStreamController.add(isolateMessage);
    }
  }

  void send(IsolateMessage message) {
    if (_clientSendPort == null) {
      throw StateError('Client SendPort is not set.');
    }
    _clientSendPort!.send(message._toMap());
  }
}
