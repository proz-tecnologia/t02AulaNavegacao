import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/home/home_page.dart';
import 'package:todo_app/src/login/login_controller.dart';

import '../../utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = LoginController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text(
              'Todo App',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.byzantium,
                  ),
            ),
            Form(
              key: _formKey,
              onChanged: () => setState(() {}),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !EmailValidator.validate(value)) {
                        return 'Preencha corretamente o e-mail';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(hintText: 'Senha'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 8) {
                        return 'Sua senha deve ter no mínimo 8 caracteres';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _formKey.currentState?.validate() == true
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                      controller
                          .login(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) {
                        Navigator.pop(context);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomePage(
                              name: 'Alencar',
                            ),
                          ),
                        );
                      });
                    }
                  : null,
              child: const Text('Entrar'),
            )
          ],
        ),
      ),
    );
  }
}
