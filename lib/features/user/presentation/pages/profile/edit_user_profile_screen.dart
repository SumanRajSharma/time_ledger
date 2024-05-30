import 'package:flutter/material.dart';
import 'package:time_ledger/features/user/domain/entities/get_user.dart';
import 'package:time_ledger/features/user/presentation/pages/profile/edit_address_page.dart';
import 'package:time_ledger/features/user/presentation/pages/profile/edit_bank_details.dart';
import 'package:time_ledger/features/user/presentation/pages/profile/edit_personal_info_page.dart';
import 'package:time_ledger/features/user/presentation/widgets/user_profile_screen/step_indicator.dart';
import 'package:time_ledger/core/util/keyboard_visibility_widget.dart';

class EditUserProfileScreen extends StatefulWidget {
  final UserEntity user;
  const EditUserProfileScreen({super.key, required this.user});
  @override
  _EditUserProfileScreenState createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 16.0),
                      child: StepIndicator(
                        currentStep: _currentPage,
                        totalSteps: 3,
                        titles: const ['Personal', 'Address', 'Bank Details'],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        children: [
                          SingleChildScrollView(
                              child: EditPersonalInfoPage(user: widget.user)),
                          SingleChildScrollView(
                              child: EditAddressPage(user: widget.user)),
                          SingleChildScrollView(
                              child: EditBankDetailsPage(user: widget.user)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: isKeyboardVisible
                            ? 8.0
                            : 16.0, // Adjust padding based on keyboard visibility
                      ),
                      child: Row(
                        children: [
                          if (_currentPage > 0)
                            OutlinedButton(
                              onPressed: _previousPage,
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(
                                    110, 48), // Adjust the size as needed
                              ),
                              child: const Text('Back'),
                            ),
                          const Spacer(),
                          if (_currentPage < 2)
                            FilledButton(
                              onPressed: _nextPage,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(
                                    110, 48), // Adjust the size as needed
                              ),
                              child: const Text('Next'),
                            ),
                          if (_currentPage == 2)
                            FilledButton(
                              onPressed: () {
                                // Handle save action
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(
                                    110, 48), // Adjust the size as needed
                              ),
                              child: const Text('Save'),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
