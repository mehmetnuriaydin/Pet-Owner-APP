// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? userName;
  String? uid;
  String? email;
  bool? veterinary;
  String? formUid;
  List<dynamic>? patientList;
  UserModel({
    this.userName,
    this.uid,
    this.email,
    this.veterinary,
    this.formUid,
    this.patientList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'uid': uid,
      'email': email,
      'veterinary': veterinary,
      'formUid': formUid,
      'patientList': patientList,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] != null ? map['userName'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      veterinary: map['veterinary'] != null ? map['veterinary'] as bool : null,
      formUid: map['formUid'] != null ? map['formUid'] as String : null,
      patientList: map['patientList'] != null
          ? List<String>.from((map['patientList'] as List<dynamic>))
          : null,
    );
  }
}
