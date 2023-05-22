// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatContactModel {
  final String name;
  final String contactId;
  final DateTime timeSent;
  ChatContactModel({
    required this.name,
    required this.contactId,
    required this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'contactId': contactId,
      'timeSent': timeSent.millisecondsSinceEpoch,
    };
  }

  factory ChatContactModel.fromMap(Map<String, dynamic> map) {
    return ChatContactModel(
      name: map['name'] as String,
      contactId: map['contactId'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
    );
  }
}
