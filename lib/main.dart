import 'package:flutter/material.dart';
import 'package:todo_app/src/authentication/splash_page.dart';
import 'package:todo_app/src/create_note/create_note_page.dart';
import 'package:todo_app/src/home/home_page.dart';
import 'package:todo_app/src/login/login_page.dart';
import 'package:todo_app/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.createNote: (context) => const CreateNote(),
      },
    );
  }
}
