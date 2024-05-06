import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/auth/domain/entities/logout.dart';

abstract class LogoutRepository {
  Future<DataState<LogoutEntity>> logoutUser();
}
