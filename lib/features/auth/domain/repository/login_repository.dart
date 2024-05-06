import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/auth/domain/entities/login.dart';

abstract class LoginRepository {
  Future<DataState<LoginEntity>> checkLoginStatus(
      {required String email, required String password});
}
