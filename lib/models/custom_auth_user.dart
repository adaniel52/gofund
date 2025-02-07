class CustomAuthUser {
  final String id;
  final String name;
  final String email;
  final bool isGuest;

  const CustomAuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.isGuest,
  });
}
