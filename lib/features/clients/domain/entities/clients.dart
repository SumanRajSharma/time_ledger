import 'package:equatable/equatable.dart';

class ClientEntity extends Equatable {
  final String id;
  final String name;
  final String address;
  final String participantName;
  final String participantNumber;
  final List<CareTypeEntity> careTypes;
  final RateEntity rate;

  const ClientEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.participantName,
    required this.participantNumber,
    required this.careTypes,
    required this.rate,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      address,
      participantName,
      participantNumber,
      careTypes,
      rate,
    ];
  }
}

class CareTypeEntity extends Equatable {
  final String careTitle;
  final String description;

  const CareTypeEntity({
    required this.careTitle,
    required this.description,
  });

  @override
  List<Object?> get props {
    return [careTitle, description];
  }
}

class RateEntity extends Equatable {
  final double? monday;
  final double? tuesday;
  final double? wednesday;
  final double? thursday;
  final double? friday;
  final double? saturday;
  final double? sunday;
  final double? publicHoliday;

  const RateEntity({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
    this.publicHoliday,
  });

  @override
  List<Object?> get props {
    return [
      monday,
      tuesday,
      wednesday,
      thursday,
      friday,
      saturday,
      sunday,
      publicHoliday,
    ];
  }
}
