class User {
  final String id;
  final String? name;
  final String? username;
  final String phone;
  final String? avatarUrl;
  final bool isVerified;

  User({
    required this.id,
    this.name,
    this.username,
    required this.phone,
    this.avatarUrl,
    required this.isVerified,
  });
}
