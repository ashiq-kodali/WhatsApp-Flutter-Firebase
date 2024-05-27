class UserModel {
  final String name;
  final String uid;
  final String profilePic;
  final String phoneNumber;
  final bool isOnline;
  final List<dynamic> groupId;

  UserModel(
      {required this.name,
      required this.uid,
      required this.profilePic,
      required this.phoneNumber,
      required this.isOnline,
      required this.groupId});

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'uid': this.uid,
      'profilePic': this.profilePic,
      'phoneNumber': this.phoneNumber,
      'isOnline': this.isOnline,
      'groupId': this.groupId,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      profilePic: map['profilePic'] as String,
      phoneNumber: map['phoneNumber'] as String,
      isOnline: map['isOnline'] as bool,
      groupId: map['groupId'] as List<dynamic>,
    );
  }
}
