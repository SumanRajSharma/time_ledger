import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String userId;
  final String token;
  final int tokenExpiration;

  const LoginEntity(
      {required this.userId,
      required this.token,
      required this.tokenExpiration});

  @override
  List<Object?> get props {
    return [userId, token, tokenExpiration];
  }
}
