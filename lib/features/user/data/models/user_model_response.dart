import 'package:time_ledger/features/user/domain/entities/get_user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.fullName,
    required super.address,
    required super.phoneNumber,
    super.abn,
    BankDetailsModel? super.bankDetails,
  });

  // From JSON factory constructor
  factory UserModel.fromJson(Map<String, dynamic> map) {
    if (map['id'] == null || map['email'] == null) {
      throw Exception('Invalid data: Missing key in the response data');
    }

    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
      address: map['address'] as String,
      phoneNumber: map['phoneNumber'] as String,
      abn: map['ABN'] as String?,
      bankDetails: map['bankDetails'] != null
          ? BankDetailsModel.fromJson(map['bankDetails'])
          : null,
    );
  }

  // From Entity factory constructor
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      fullName: entity.fullName,
      address: entity.address,
      phoneNumber: entity.phoneNumber,
      abn: entity.abn,
      bankDetails: entity.bankDetails != null
          ? BankDetailsModel.fromEntity(entity.bankDetails!)
          : null,
    );
  }
}

class BankDetailsModel extends BankDetailsEntity {
  const BankDetailsModel({
    required super.accountName,
    required super.accountNumber,
    required super.bsb,
  });

  factory BankDetailsModel.fromJson(Map<String, dynamic> json) {
    return BankDetailsModel(
      accountName: json['accountName'] as String,
      accountNumber: json['accountNumber'] as String,
      bsb: json['BSB'] as String,
    );
  }

  factory BankDetailsModel.fromEntity(BankDetailsEntity entity) {
    return BankDetailsModel(
      accountName: entity.accountName,
      accountNumber: entity.accountNumber,
      bsb: entity.bsb,
    );
  }
}
