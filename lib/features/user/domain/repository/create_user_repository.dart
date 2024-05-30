import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/user/domain/entities/create_user.dart';

abstract class CreateUserRepository {
  Future<DataState<CreateUserEntity>> createUser({
    required String email,
    required String fullName,
    required String phoneNumber,
    required String password,
  });
}
