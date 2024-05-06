import 'package:time_ledger/core/usecases/noparam.dart';
import 'package:time_ledger/core/usecases/usecase.dart';
import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/auth/domain/entities/logout.dart';
import 'package:time_ledger/features/auth/domain/repository/logout_repository.dart';

class LogoutUserUseCase implements UseCase<DataState<LogoutEntity>, NoParams> {
  final LogoutRepository _logoutRepository;

  LogoutUserUseCase(this._logoutRepository);

  @override
  Future<DataState<LogoutEntity>> call({NoParams? params}) {
    return _logoutRepository.logoutUser();
  }
}
