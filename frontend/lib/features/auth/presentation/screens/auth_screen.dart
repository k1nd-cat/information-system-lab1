import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/presentation/screens/widgets/lab_auth_button.dart';
import 'package:frontend/features/auth/presentation/screens/widgets/lab_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isRegister = false;
  bool isAdminController = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, '/main');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error.otherError ?? "Ошибка авторицации")),
            );
          }
        },
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: IntrinsicHeight(
              child: _loginForm(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final loginController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordCheckController = TextEditingController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: LabTextField(
            controller: loginController,
            type: LabTextFieldType.login,
            title: 'Логин',
            errorText: "",
          ),
        ),
        if (isRegister)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isAdminController,
                    activeColor: const Color.fromRGBO(161, 231, 165, 1),
                    onChanged: (value) {
                      setState(() {
                        isAdminController = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text('Стать администратором'),
                ],
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: LabTextField(
            controller: passwordController,
            type: LabTextFieldType.password,
            title: 'Пароль',
            errorText: "",
          ),
        ),
        if (isRegister)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: LabTextField(
              controller: passwordCheckController,
              type: LabTextFieldType.password,
              title: 'Повторить пароль',
              errorText: "",
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: LabLoginRegisterButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(
                !isRegister
                    ? LoginRequest(
                        login: loginController.text,
                        password: passwordController.text,
                      )
                    : RegisterRequest(
                        login: loginController.text,
                        password: passwordCheckController.text,
                        isAdmin: isAdminController,
                      ),
              );
            },
          ),
        ),
        LabArentRegisterButton(
          text: !isRegister ? 'Регистрация' : 'Уже есть аккаунт',
          onPressed: () {
            setState(() {
              isRegister = !isRegister;
            });
          },
        ),
      ],
    );
  }
}
