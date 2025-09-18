class UserStatsModel {
  final String lastLogin;
  final List<Map<String, dynamic>> requestsPerMonth;

  UserStatsModel({
    required this.lastLogin,
    required this.requestsPerMonth,
  });

  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      lastLogin: json['lastLogin'],
      requestsPerMonth: List<Map<String, dynamic>>.from(json['requestsPerMonth']),
    );
  }
}
