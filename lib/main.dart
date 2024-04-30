import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:time_ledger/config/routes/routes.dart';
import 'package:time_ledger/config/theme/app_themes.dart';
import 'package:time_ledger/features/user/presentation/pages/home_screen.dart';

Future<void> main() async {
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: const HomeScreen(),
    );
  }
}
