class UserModel {
  final String name;
  final String email;
  final String token;
  final bool? notifications;
  final String? lastLogin;

  UserModel({
    required this.name,
    required this.email,
    required this.token,
    this.notifications,
    this.lastLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      token: json['token'],
      notifications: json['notifications'],
      lastLogin: json['lastLogin'],
    );
  }
}
