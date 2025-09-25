class User {
  final String name;
  final String email;
  final String token;
  final bool? notifications;
  final String? lastLogin;

  User({
    required this.name,
    required this.email,
    required this.token,
    this.notifications,
    this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      token: json['token'],
      notifications: json['notifications'],
      lastLogin: json['lastLogin'],
    );
  }
}
