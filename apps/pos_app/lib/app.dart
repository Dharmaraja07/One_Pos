import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'router/app_router.dart';

class UniversalPosApp extends StatelessWidget {
  const UniversalPosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Universal POS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
