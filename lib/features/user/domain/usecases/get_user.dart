import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/core/usecases/usecase.dart';
import 'package:time_ledger/features/user/domain/entities/get_user.dart';
import 'package:time_ledger/features/user/domain/repository/get_user_repository.dart';

class GetUserUseCase
    implements UseCase<DataState<UserEntity>, Map<String, dynamic>> {
  final GetUserRepository getUserRepository;

  GetUserUseCase(this.getUserRepository);
  @override
  Future<DataState<UserEntity>> call({Map<String, dynamic>? params}) async {
    return await getUserRepository.getUser();
  }
}
