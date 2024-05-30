import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/auth/domain/repository/token_repository.dart';
import 'package:time_ledger/service/token_service.dart';

/// Implementation of `TokenRepository` using `SecureTokenService`.
class TokenRepositoryImpl implements TokenRepository {
  final SecureTokenService tokenService;

  TokenRepositoryImpl({required this.tokenService});

  /// Checks if the stored token is valid or expired.
  @override
  Future<DataState<bool>> isTokenValid() async {
    final token = await tokenService.getToken();
    if (token == null || tokenService.isTokenExpired(token)) {
      return const DataSuccess(false);
    }
    return const DataSuccess(true);
  }

  /// Deletes the stored token using the secure service.
  @override
  Future<void> deleteToken() async {
    await tokenService.deleteToken();
  }
}
