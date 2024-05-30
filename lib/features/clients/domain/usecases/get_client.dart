import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/core/usecases/usecase.dart';
import 'package:time_ledger/features/clients/domain/entities/clients.dart';
import 'package:time_ledger/features/clients/domain/repository/get_client_repository.dart';

class GetClientUseCase
    implements UseCase<DataState<List<ClientEntity>>, Map<String, dynamic>> {
  final GetClientRepository getClientRepository;

  GetClientUseCase(this.getClientRepository);
  @override
  Future<DataState<List<ClientEntity>>> call(
      {Map<String, dynamic>? params}) async {
    return await getClientRepository.getClients();
  }
}
