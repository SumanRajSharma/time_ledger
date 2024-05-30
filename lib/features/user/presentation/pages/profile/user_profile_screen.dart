import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:time_ledger/features/user/domain/entities/get_user.dart';
import 'package:time_ledger/features/user/presentation/widgets/user_profile_screen/abn_card.dart';
import 'package:time_ledger/features/user/presentation/widgets/user_profile_screen/address_card.dart';
import 'package:time_ledger/features/user/presentation/widgets/user_profile_screen/address_helper.dart';
import 'package:time_ledger/features/user/presentation/widgets/user_profile_screen/bank_details_card.dart';
import 'package:time_ledger/features/user/presentation/widgets/user_profile_screen/profile_header.dart';
import 'package:time_ledger/features/user/presentation/widgets/user_profile_screen/section_title.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity user;

  const ProfilePage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final parsedAddress = parseAddress(user.address);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ProfileHeader(user: user),
            const SizedBox(height: 32),
            const SectionTitle(title: 'Address'),
            const SizedBox(height: 8),
            AddressCard(parsedAddress: parsedAddress),
            const SizedBox(height: 32),
            const SectionTitle(title: 'ABN Details'),
            const SizedBox(height: 8),
            ABNCard(abn: user.abn),
            const SizedBox(height: 32),
            const SectionTitle(title: 'Bank Details'),
            const SizedBox(height: 8),
            const BankDetailsCard(),
          ],
        ),
      ),
    );
  }
}
