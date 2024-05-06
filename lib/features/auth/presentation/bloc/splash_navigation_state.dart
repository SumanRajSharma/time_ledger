import 'package:equatable/equatable.dart';

abstract class SplashNavigationState extends Equatable {
  const SplashNavigationState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashNavigationState {
  const SplashInitial();
}

class NavigateToLogin extends SplashNavigationState {
  const NavigateToLogin();
}

class NavigateToHome extends SplashNavigationState {
  const NavigateToHome();
}
