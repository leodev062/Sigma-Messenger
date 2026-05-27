class UserEntity {
  final String id;
  final String? name;
  final String? username;
  final String? bio;
  final String phone;
  final String? avatarUrl;
  final bool isVerified;

  UserEntity({
    required this.id,
    this.name,
    this.username,
    this.bio,
    required this.phone,
    this.avatarUrl,
    this.isVerified = false,
  });
}
