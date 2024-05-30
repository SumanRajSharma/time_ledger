import 'package:time_ledger/features/clients/domain/entities/clients.dart';

class ClientModel extends ClientEntity {
  const ClientModel({
    required super.id,
    required super.name,
    required super.address,
    required super.participantName,
    required super.participantNumber,
    required super.careTypes,
    required super.rate,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      participantName: json['participant_name'] as String,
      participantNumber: json['participant_number'] as String,
      careTypes: (json['care_type'] as List)
          .map((e) => CareTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      rate: RateModel.fromJson(json['rate']),
    );
  }

  factory ClientModel.fromEntity(ClientEntity entity) {
    return ClientModel(
      id: entity.id,
      name: entity.name,
      address: entity.address,
      participantName: entity.participantName,
      participantNumber: entity.participantNumber,
      careTypes:
          entity.careTypes.map((e) => CareTypeModel.fromEntity(e)).toList(),
      rate: RateModel.fromEntity(entity.rate),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'participant_name': participantName,
      'participant_number': participantNumber,
      'care_type': careTypes.map((e) => (e as CareTypeModel).toJson()).toList(),
      'rate': (rate as RateModel).toJson(),
    };
  }
}

class CareTypeModel extends CareTypeEntity {
  const CareTypeModel({
    required super.careTitle,
    required super.description,
  });

  factory CareTypeModel.fromJson(Map<String, dynamic> json) {
    return CareTypeModel(
      careTitle: json['care_title'] as String,
      description: json['description'] as String,
    );
  }

  factory CareTypeModel.fromEntity(CareTypeEntity entity) {
    return CareTypeModel(
      careTitle: entity.careTitle,
      description: entity.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'care_title': careTitle,
      'description': description,
    };
  }
}

class RateModel extends RateEntity {
  const RateModel({
    required super.monday,
    required super.tuesday,
    required super.wednesday,
    required super.thursday,
    required super.friday,
    required super.saturday,
    required super.sunday,
    required super.publicHoliday,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      monday: (json['monday'] as num?)?.toDouble(),
      tuesday: (json['tuesday'] as num?)?.toDouble(),
      wednesday: (json['wednesday'] as num?)?.toDouble(),
      thursday: (json['thursday'] as num?)?.toDouble(),
      friday: (json['friday'] as num?)?.toDouble(),
      saturday: (json['saturday'] as num?)?.toDouble(),
      sunday: (json['sunday'] as num?)?.toDouble(),
      publicHoliday: (json['public_holiday'] as num?)?.toDouble(),
    );
  }

  factory RateModel.fromEntity(RateEntity entity) {
    return RateModel(
      monday: entity.monday,
      tuesday: entity.tuesday,
      wednesday: entity.wednesday,
      thursday: entity.thursday,
      friday: entity.friday,
      saturday: entity.saturday,
      sunday: entity.sunday,
      publicHoliday: entity.publicHoliday,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
      'sunday': sunday,
      'public_holiday': publicHoliday,
    };
  }
}
