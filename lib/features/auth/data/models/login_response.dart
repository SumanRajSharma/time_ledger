import 'package:time_ledger/features/auth/domain/entities/login.dart';

class LoginModel extends LoginEntity {
  const LoginModel({
    required super.userId,
    required super.token,
    required super.tokenExpiration,
  });

  factory LoginModel.fromJson(Map<String, dynamic> map) {
    if (map['userId'] == null ||
        map['token'] == null ||
        map['tokenExpiration'] == null) {
      throw Exception('Invalid data: Missing key in the response data');
    }
    return LoginModel(
      userId: map['userId'] as String,
      token: map['token'] as String,
      tokenExpiration: map['tokenExpiration'],
    );
  }

  factory LoginModel.fromEntity(LoginEntity entity) {
    return LoginModel(
        userId: entity.userId,
        token: entity.token,
        tokenExpiration: entity.tokenExpiration);
  }
}
