import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/core/usecases/usecase.dart';
import 'package:time_ledger/features/user/domain/entities/create_user.dart';
import 'package:time_ledger/features/user/domain/repository/create_user_repository.dart';

class CreateUserUseCase
    implements UseCase<DataState<CreateUserEntity>, Map<String, dynamic>> {
  final CreateUserRepository _createUserRepository;

  CreateUserUseCase(this._createUserRepository);
  @override
  Future<DataState<CreateUserEntity>> call({Map<String, dynamic>? params}) {
    return _createUserRepository.createUser(
        fullName: params?['fullName'],
        email: params?['email'],
        password: params?['password'],
        phoneNumber: params?['phoneNumber']);
  }
}
