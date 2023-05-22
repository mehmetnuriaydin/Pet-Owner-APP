class MessageModel {
  final String senderId;
  final String recieverId;
  final String text;
  final DateTime timeSent;
  final String messageId;
  MessageModel({
    required this.senderId,
    required this.recieverId,
    required this.text,
    required this.timeSent,
    required this.messageId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'recieverId': recieverId,
      'text': text,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] as String,
      recieverId: map['recieverId'] as String,
      text: map['text'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      messageId: map['messageId'] as String,
    );
  }
}
