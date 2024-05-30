import 'package:time_ledger/features/user/domain/entities/create_user.dart';

class CreateUserModel extends CreateUserEntity {
  const CreateUserModel({
    required super.id,
    required super.email,
  });

  factory CreateUserModel.fromJson(Map<String, dynamic> map) {
    if (map['id'] == null || map['email'] == null) {
      throw Exception('Invalid data: Missing key in the response data');
    }
    return CreateUserModel(
      id: map['id'] as String,
      email: map['email'] as String,
    );
  }

  factory CreateUserModel.fromEntity(CreateUserEntity entity) {
    return CreateUserModel(id: entity.id, email: entity.email);
  }
}
