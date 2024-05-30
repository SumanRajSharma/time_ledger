import 'package:equatable/equatable.dart';

abstract class SplashNavigationEvent extends Equatable {
  const SplashNavigationEvent();

  @override
  List<Object?> get props => [];
}

class DetermineInitialPage extends SplashNavigationEvent {
  const DetermineInitialPage();
}
