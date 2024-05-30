import 'package:equatable/equatable.dart';
import 'package:time_ledger/features/clients/domain/entities/clients.dart';

abstract class CreateClientEvent extends Equatable {
  const CreateClientEvent();

  @override
  List<Object> get props => [];
}

class SubmitClient extends CreateClientEvent {
  final String name;
  final String address;
  final String participantName;
  final String participantNumber;
  final List<CareTypeEntity> careTypes;
  final RateEntity rate;

  const SubmitClient({
    required this.name,
    required this.address,
    required this.participantName,
    required this.participantNumber,
    required this.careTypes,
    required this.rate,
  });

  @override
  List<Object> get props =>
      [name, address, participantName, participantNumber, careTypes, rate];
}
