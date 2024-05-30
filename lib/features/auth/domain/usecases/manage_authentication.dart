import 'package:time_ledger/core/navigation/app_state.dart';
import 'package:time_ledger/service/token_service.dart';

class ManageAuthentication {
  final AppState appState;
  final SecureTokenService tokenService;

  ManageAuthentication(this.appState, this.tokenService);

  void login() {
    appState.login();
  }

  void logout() {
    appState.logout();
    tokenService.deleteToken(); // Clear the token on logout
  }

  Future<void> checkSession() async {
    // Retrieve the token and check its validity
    String? token = await tokenService.getToken();
    bool isTokenValid = token != null && !tokenService.isTokenExpired(token);
    if (isTokenValid) {
      appState.login();
    } else {
      appState.logout();
    }
  }
}
