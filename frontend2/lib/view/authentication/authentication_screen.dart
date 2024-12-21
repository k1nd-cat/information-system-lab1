import 'package:flutter/material.dart';
import 'package:frontend2/view/authentication/widgets/auth_text_field.dart';
import 'package:frontend2/viewmodel/authentication_viewmodel.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool isRegister = false;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthenticationViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies App'),
        automaticallyImplyLeading: false,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (authViewModel.errorMessage != null)
                  Center(
                    child: Text(
                      authViewModel.errorMessage!,
                      style: const TextStyle(
                          color: Color.fromRGBO(89, 49, 49, 1.0)),
                    ),
                  ),
                if (authViewModel.errorMessage != null)
                  const SizedBox(height: 15),
                // Username
                AuthTextField(
                  controller: authViewModel.usernameController,
                  type: AuthTextFieldType.username,
                  errorMessage: authViewModel.usernameError,
                ),
                const SizedBox(height: 10),
                // Password
                AuthTextField(
                  controller: authViewModel.passwordController,
                  type: AuthTextFieldType.password,
                  errorMessage: authViewModel.passwordError,
                ),
                if (isRegister) const SizedBox(height: 10),
                if (isRegister)
                  // Repeat password
                  AuthTextField(
                    controller: authViewModel.repeatPasswordController,
                    type: AuthTextFieldType.repeatPassword,
                    errorMessage: authViewModel.repeatPasswordError,
                  ),
                if (isRegister) const SizedBox(height: 15),
                if (isRegister)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: authViewModel.isWaitingAdmin,
                        activeColor: const Color.fromRGBO(242, 196, 206, 1),
                        checkColor: const Color.fromRGBO(44, 43, 48, 1),
                        onChanged: (value) {
                          setState(() {
                            authViewModel.isWaitingAdmin = value!;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      const Text('Хочу стать администратором'),
                    ],
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    bool success;
                    if (isRegister) {
                      success = await authViewModel.signUp();
                    } else {
                      success = await authViewModel.signIn();
                    }

                    if (success && mounted) {
                      Navigator.popAndPushNamed(context, '/home');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(44, 43, 48, 1),
                    minimumSize: const Size(300, 54),
                    backgroundColor: const Color.fromRGBO(242, 196, 206, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: Text(isRegister ? 'Зарегистрироваться' : 'Войти'),
                ),
                const SizedBox(height: 15),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      isRegister = !isRegister;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    // foregroundColor: Color.fromRGBO(1, 1, 1, 1)
                    foregroundColor: const Color.fromRGBO(242, 196, 206, 1),
                    side: const BorderSide(
                        color: Color.fromRGBO(242, 196, 206, 1), width: 1),
                    minimumSize: const Size(300, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: Text(isRegister ? 'Вход' : 'Регистрация'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
