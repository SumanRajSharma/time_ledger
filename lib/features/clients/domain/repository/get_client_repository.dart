import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/clients/domain/entities/clients.dart';

abstract class GetClientRepository {
  Future<DataState<List<ClientEntity>>> getClients();
}
