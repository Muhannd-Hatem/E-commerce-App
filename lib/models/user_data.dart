class UserData {
  final String id;
  final String email;
  final String userName;
  final String createdAt;

  UserData({
    required this.id,
    required this.email,
    required this.userName,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'createdAt': createdAt,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      userName: map['userName'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }
}
