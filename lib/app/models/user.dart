class UserModel {
  final String uId;
  final String name;
  final String phone;
  final String profilPict;
  final bool isOnline;

  UserModel({
    required this.uId,
    required this.name,
    required this.phone,
    required this.profilPict,
    required this.isOnline,
  });

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'phone': phone,
      'profilPict': profilPict,
      'isOnline': isOnline,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uId: map['uId'] ?? '',
        name: map['name'] ?? '',
        phone: map['phone'] ?? '',
        profilPict: map['profilPict'] ?? '',
        isOnline: map['isOnline'] ?? false);
  }
}
