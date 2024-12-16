import 'package:flutter/material.dart';
import 'package:frontend2/model/user.dart';
import 'package:frontend2/view/home/widgets/map_view.dart';
import 'package:frontend2/view/home/widgets/show_profile.dart';
import 'package:frontend2/view/home/widgets/show_waiting_admin.dart';
import 'package:frontend2/viewmodel/authentication/authentication_viewmodel.dart';
import 'package:frontend2/viewmodel/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthenticationViewModel>(context);
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies App'),
        automaticallyImplyLeading: false,
        actions: [
          if (authViewModel.user.role == Role.ROLE_ADMIN)
            const ShowWaitingAdmin(),
          const ShowProfile(),
          const SizedBox(width: 15),
        ],
      ),
      body: const Center(child:MoviesMap()),
    );
  }
}
