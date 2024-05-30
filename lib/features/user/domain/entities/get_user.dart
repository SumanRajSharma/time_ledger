import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String address;
  final String phoneNumber;
  final String? abn;
  final BankDetailsEntity? bankDetails;

  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.address,
    required this.phoneNumber,
    this.abn,
    this.bankDetails,
  });

  @override
  List<Object?> get props {
    return [id, email, fullName, address, phoneNumber, abn, bankDetails];
  }
}

class BankDetailsEntity extends Equatable {
  final String accountName;
  final String accountNumber;
  final String bsb;

  const BankDetailsEntity({
    required this.accountName,
    required this.accountNumber,
    required this.bsb,
  });

  @override
  List<Object?> get props {
    return [accountName, accountNumber, bsb];
  }
}
