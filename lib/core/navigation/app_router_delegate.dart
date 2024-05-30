import 'package:flutter/material.dart';
import 'package:time_ledger/features/auth/domain/usecases/manage_authentication.dart';
import 'package:time_ledger/features/auth/presentation/pages/login_page.dart';
import 'package:time_ledger/features/user/presentation/pages/home/home_screen.dart';
import 'app_state.dart';
import 'page_config.dart';

class AppRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final ManageAuthentication manageAuthentication;
  final AppState appState;

  AppRouterDelegate(this.manageAuthentication, this.appState)
      : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appState.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  PageConfiguration? get currentConfiguration => appState.isLoggedIn
      ? const PageConfiguration(PageType.home)
      : const PageConfiguration(PageType.login);

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async {
    switch (configuration.type) {
      case PageType.home:
        manageAuthentication.login();
        break;
      case PageType.login:
        manageAuthentication.logout();
        break;
      case PageType.profile:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (!appState.isLoggedIn)
          const MaterialPage(child: LoginPage())
        else
          const MaterialPage(child: HomeScreen()),
      ],
      onPopPage: (route, result) => route.didPop(result),
    );
  }
}
