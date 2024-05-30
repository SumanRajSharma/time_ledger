import 'package:equatable/equatable.dart';

abstract class GetUserEvent extends Equatable {
  const GetUserEvent();

  @override
  List<Object?> get props => [];
}

class FetchUser extends GetUserEvent {
  const FetchUser();

  @override
  List<Object?> get props => [];
}
