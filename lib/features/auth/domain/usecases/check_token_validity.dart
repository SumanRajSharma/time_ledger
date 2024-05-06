import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/core/usecases/usecase.dart';
import 'package:time_ledger/features/auth/domain/repository/token_repository.dart';
import 'package:time_ledger/core/usecases/noparam.dart';

/// Use case for checking the validity of the current session token.
class CheckTokenValidityUseCase implements UseCase<DataState<bool>, NoParams> {
  final TokenRepository tokenRepository;

  CheckTokenValidityUseCase({required this.tokenRepository});

  /// Calls the repository to verify the validity of the stored token.
  @override
  Future<DataState<bool>> call({NoParams? params}) async {
    return await tokenRepository.isTokenValid();
  }
}
