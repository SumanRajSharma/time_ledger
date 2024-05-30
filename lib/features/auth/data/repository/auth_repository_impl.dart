// data/repositories/auth_repository_impl.dart
import 'package:time_ledger/features/auth/domain/repository/auth_repository.dart';
import 'package:time_ledger/service/token_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SecureTokenService tokenService;

  AuthRepositoryImpl(this.tokenService);

  @override
  Future<bool> isTokenValid() async {
    String? token = await tokenService.getToken();
    if (token == null) return false;
    return !tokenService.isTokenExpired(token);
  }
}
