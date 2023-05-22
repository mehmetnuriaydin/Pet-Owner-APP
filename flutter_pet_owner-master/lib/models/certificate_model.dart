// ignore_for_file: public_member_api_docs, sort_constructors_first
class HealthCertificateModel {
  final String senderId;
  final String recieverId;
  final Map<String, dynamic> map;
  final DateTime timeSent;
  final String certificateId;
  HealthCertificateModel({
    required this.senderId,
    required this.recieverId,
    required this.map,
    required this.timeSent,
    required this.certificateId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'recieverId': recieverId,
      'map': map,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'certificateId': certificateId,
    };
  }

  factory HealthCertificateModel.fromMap(Map<String, dynamic> map) {
    return HealthCertificateModel(
      senderId: map['senderId'] as String,
      recieverId: map['recieverId'] as String,
      map: Map<String, dynamic>.from((map['map'] as Map<String, dynamic>)),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      certificateId: map['certificateId'] as String,
    );
  }
}
