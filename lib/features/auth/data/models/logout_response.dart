import 'package:time_ledger/features/auth/domain/entities/logout.dart';

class LogoutModel extends LogoutEntity {
  const LogoutModel({
    required super.logout,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    if (json['logout'] == null) {
      throw Exception('Invalid data: Missing key in the response data');
    }
    return LogoutModel(
      logout: json['logout'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logout': logout,
    };
  }

  factory LogoutModel.fromEntity(LogoutEntity entity) {
    return LogoutModel(logout: entity.logout);
  }
}
