import 'package:equatable/equatable.dart';

class LogoutEntity extends Equatable {
  final bool logout;

  const LogoutEntity({
    required this.logout,
  });

  @override
  List<Object?> get props {
    return [logout];
  }
}
