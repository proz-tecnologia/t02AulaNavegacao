import 'package:flutter/material.dart';
import 'package:todo_app/src/authentication/splash_controller.dart';
import 'package:todo_app/src/authentication/splash_state.dart';
import 'package:todo_app/utils/app_routes.dart';

import '../home/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController controller = SplashController();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) async {
        controller.isAuthenticated().then((value) {
          if (value.runtimeType == SplashStateAuthenticated) {
            final state = value as SplashStateAuthenticated;
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.home,
              arguments: HomeArguments(name: state.username),
            );
          } else if (value.runtimeType == SplashStateUnauthenticated) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.login,
            );
          }
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Our TODO application'),
      ),
    );
  }
}
