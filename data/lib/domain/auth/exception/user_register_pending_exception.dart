class UserRegisterPendingException implements Exception {
  final String email;
  final String domain;

  const UserRegisterPendingException({
    required this.email,
    required this.domain,
  });
}
