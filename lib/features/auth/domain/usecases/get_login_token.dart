import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/core/usecases/usecase.dart';
import 'package:time_ledger/features/auth/domain/entities/login.dart';
import 'package:time_ledger/features/auth/domain/repository/login_repository.dart';

class GetLoginTokenUseCase
    implements UseCase<DataState<LoginEntity>, Map<String, dynamic>> {
  final LoginRepository _loginRepository;

  GetLoginTokenUseCase(this._loginRepository);
  @override
  Future<DataState<LoginEntity>> call({Map<String, dynamic>? params}) {
    return _loginRepository.checkLoginStatus(
        email: params?['email'], password: params?['password']);
  }
}
