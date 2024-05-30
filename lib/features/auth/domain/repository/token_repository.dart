import 'package:time_ledger/core/resources/data_state.dart';

abstract class TokenRepository {
  Future<DataState<bool>> isTokenValid();

  Future<void> deleteToken();
}
