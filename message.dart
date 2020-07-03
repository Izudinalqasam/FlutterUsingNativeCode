import 'package:pigeon/pigeon_lib.dart';

class MessageReply {
  String query;
}

class MessageRequest {
  String result;
}

@HostApi()
abstract class Api {
  MessageReply sendMessage(MessageRequest messageRequest);
}