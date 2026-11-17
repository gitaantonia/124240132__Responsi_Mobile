import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/login.dart';
import 'screens/main_navigation.dart';
import 'services/auth_service.dart';
import 'services/library_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LibraryService.getLibrary();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  final isLoggedIn = await AuthService.isLoggedIn();
  runApp(MainApp(isLoggedIn: isLoggedIn));

}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;

  const MainApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Browse Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? const MainNavigation() : const LoginScreen(),
    );
  }
}
