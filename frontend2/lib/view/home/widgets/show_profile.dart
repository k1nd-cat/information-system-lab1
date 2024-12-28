import 'package:flutter/material.dart';
import 'package:frontend2/viewmodel/authentication_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../model/user.dart';

class ShowProfile extends StatelessWidget {
  const ShowProfile({super.key});

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          var authViewModel = Provider.of<AuthenticationViewModel>(context);
          return AlertDialog(
            backgroundColor: const Color.fromRGBO(44, 43, 48, 1),
            title: Text(
              authViewModel.user!.username,
              style: const TextStyle(color: Color.fromRGBO(214, 214, 214, 1)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Text(
                  'Роль: ${authViewModel.user!.role == Role.ROLE_ADMIN ? 'администратор' : 'пользователь'}',
                ),
                const SizedBox(height: 12),
                if (authViewModel.user!.isWaitingAdmin)
                  const Text(
                    'Запрос на админа отправлен',
                  ),
                if (!authViewModel.user!.isWaitingAdmin && authViewModel.user!.role == Role.ROLE_USER)
                  Center(
                    child: ElevatedButton(
                      onPressed: () => authViewModel.setWaitingAdmin(),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color.fromRGBO(44, 43, 48, 1),
                        minimumSize: const Size(100, 40),
                        backgroundColor: const Color.fromRGBO(242, 196, 206, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      child: const Text('Cтать администратором'),
                    ),
                  ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Color.fromRGBO(242, 196, 206, 1.0),
                ),
                onPressed: () async {
                  await authViewModel.logout();
                  Navigator.popAndPushNamed(context, '/auth');
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.account_box,
        size: 41,
        color: Color.fromRGBO(214, 214, 214, 1),
      ),
      onPressed: () => _dialogBuilder(context),
    );
  }
}
