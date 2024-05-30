import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/user/domain/entities/get_user.dart';

abstract class GetUserRepository {
  Future<DataState<UserEntity>> getUser();
}
