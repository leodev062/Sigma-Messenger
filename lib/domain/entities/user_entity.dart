class UserEntity {
  final String id;
  final String? name;
  final String? username;
  final String phone;
  final String? avatarUrl;
  final bool isVerified;

  UserEntity({
    required this.id,
    this.name,
    this.username,
    required this.phone,
    this.avatarUrl,
    this.isVerified = false,
  });
}
