import 'package:equatable/equatable.dart';

abstract class GetClientsEvent extends Equatable {
  const GetClientsEvent();

  @override
  List<Object?> get props => [];
}

class FetchClients extends GetClientsEvent {
  const FetchClients();

  @override
  List<Object?> get props => [];
}
