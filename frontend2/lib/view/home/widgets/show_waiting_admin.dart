import 'package:flutter/material.dart';
import 'package:frontend2/viewmodel/authentication_viewmodel.dart';
import 'package:frontend2/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../widgets/styled_loading.dart';

class ShowWaitingAdmin extends StatefulWidget {
  const ShowWaitingAdmin({super.key});

  @override
  State<ShowWaitingAdmin> createState() => _ShowWaitingAdminState();
}

class _ShowWaitingAdminState extends State<ShowWaitingAdmin> {
  final ValueNotifier<List<String>> _usernamesNotifier = ValueNotifier<List<String>>([]);

  Future<void> _dialogBuilder(BuildContext context) async {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(44, 43, 48, 1),
          title: const Text(
            'Заявки в администраторы',
            style: TextStyle(color: Color.fromRGBO(214, 214, 214, 1)),
          ),
          content: SizedBox(
            height: 300,
            width: 300,
            child: FutureBuilder<List<String>>(
              future: homeViewModel.getWaitingAdminUsernames(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: StyledLoading());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData  || snapshot.data!.isEmpty) {
                  return const Text('No data available');
                } else {
                  _usernamesNotifier.value = snapshot.data!;
                  if (_usernamesNotifier.value.isEmpty) {
                    return const Text(
                      'Пока нет пользователей',
                      style: TextStyle(color: Color.fromRGBO(214, 214, 214, 1)),
                    );
                  }
                  return ValueListenableBuilder<List<String>>(
                    valueListenable: _usernamesNotifier,
                    builder: (context, usernames, _) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: usernames.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  usernames[index],
                                  style: const TextStyle(
                                      color: Color.fromRGBO(214, 214, 214, 1)),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      color: const Color.fromRGBO(0, 110, 100, 1.0),
                                      onPressed: () {
                                        homeViewModel.approveAdminByUsername(usernames[index]);
                                        _usernamesNotifier.value = List.from(_usernamesNotifier.value)
                                          ..removeAt(index);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.cancel_outlined),
                                      color: const Color.fromRGBO(180, 49, 39, 1.0),
                                      onPressed: () {
                                        homeViewModel.rejectAdminByUsername(usernames[index]);
                                        _usernamesNotifier.value = List.from(_usernamesNotifier.value)
                                          ..removeAt(index);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'ok',
                style: TextStyle(color: Color.fromRGBO(242, 196, 206, 1)),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => _dialogBuilder(context),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color.fromRGBO(214, 214, 214, 1),
        side: const BorderSide(
            color: Color.fromRGBO(214, 214, 214, 1), width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      child: const Text(
        'Заявки в администраторы',
        style: TextStyle(
          color: Color.fromRGBO(214, 214, 214, 1),
        ),
      ),
    );
  }
}
 