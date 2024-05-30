import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/core/usecases/usecase.dart';
import 'package:time_ledger/features/clients/domain/entities/clients.dart';
import 'package:time_ledger/features/clients/domain/repository/create_client_repository.dart';

class CreateClientUseCase
    implements UseCase<DataState<ClientEntity>, Map<String, dynamic>> {
  final CreateClientRepository _createClientRepository;

  CreateClientUseCase(this._createClientRepository);

  @override
  Future<DataState<ClientEntity>> call({Map<String, dynamic>? params}) {
    final careTypes = (params?['careTypes'] as List<dynamic>)
        .map((careType) => CareTypeEntity(
              careTitle: careType['careTitle'],
              description: careType['description'],
            ))
        .toList();

    final rate = RateEntity(
      monday: params?['rate']['monday'],
      tuesday: params?['rate']['tuesday'],
      wednesday: params?['rate']['wednesday'],
      thursday: params?['rate']['thursday'],
      friday: params?['rate']['friday'],
      saturday: params?['rate']['saturday'],
      sunday: params?['rate']['sunday'],
      publicHoliday: params?['rate']['publicHoliday'],
    );

    return _createClientRepository.createClient(
      name: params?['name'],
      address: params?['address'],
      participantName: params?['participantName'],
      participantNumber: params?['participantNumber'],
      careTypes: careTypes,
      rate: rate,
    );
  }
}
