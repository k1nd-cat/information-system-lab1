import 'package:flutter/material.dart';
import 'package:frontend2/view/widgets/styled_loading.dart';
import 'package:provider/provider.dart';

import '../viewmodel/authentication_viewmodel.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie app"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<AuthenticationViewModel>(context, listen: false)
              .checkAuthStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const StyledLoading();
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final authViewModel = Provider.of<AuthenticationViewModel>(
                  context,
                  listen: false,
                );
                Navigator.popAndPushNamed(
                  context,
                  authViewModel.isAuthenticated ? '/home' : '/auth',
                );
              });
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
