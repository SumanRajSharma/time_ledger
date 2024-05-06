import 'package:flutter/foundation.dart';
import 'page_config.dart';

class AppState extends ChangeNotifier {
  bool isLoggedIn = false;

  PageConfiguration get initialPage => isLoggedIn
      ? const PageConfiguration(PageType.home)
      : const PageConfiguration(PageType.login);

  void login() {
    isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    isLoggedIn = false;
    notifyListeners();
  }
}
