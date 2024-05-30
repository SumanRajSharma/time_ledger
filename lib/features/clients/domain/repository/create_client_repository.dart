import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/clients/domain/entities/clients.dart';

abstract class CreateClientRepository {
  Future<DataState<ClientEntity>> createClient({
    required String name,
    required String address,
    required String participantName,
    required String participantNumber,
    required List<CareTypeEntity> careTypes,
    required RateEntity rate,
  });
}
