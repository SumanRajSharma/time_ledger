// file: components/register_page_app_bar.dart

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RegisterPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? onLeadingPressed;

  const RegisterPageAppBar({
    super.key,
    this.onLeadingPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      title: Transform.translate(
        offset: const Offset(-20, 0),
        child: const _RegisterAppBarTitle(),
      ),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Iconsax.arrow_left,
            color: Theme.of(context).colorScheme.onSurface),
        onPressed: onLeadingPressed ?? () => Navigator.pop(context),
      ),
    );
  }
}

class _RegisterAppBarTitle extends StatelessWidget {
  const _RegisterAppBarTitle();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/logo/logo2.png', width: 28, height: 28),
        const SizedBox(width: 8),
        Text(
          'Time Ledger',
          style: TextStyle(
            fontFamily: 'Bangers',
            fontSize: 36,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
