import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/presentation/screens/auth_screen.dart';
import 'package:frontend/features/main/domain/usecases/main_usecase.dart';
import 'package:frontend/features/main/presentation/bloc/main_bloc.dart';
import 'package:frontend/features/main/presentation/screens/main_screen.dart';
import 'package:frontend/features/navigation/bloc/navigation_bloc.dart';
import 'package:frontend/features/navigation/bloc/navigation_state.dart';

class Lab1RouterDelegate extends RouterDelegate<Object>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Object> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final NavigationBloc navigationBloc;

  Lab1RouterDelegate(this.navigationBloc)
      : navigatorKey = GlobalKey<NavigatorState>() {
    navigationBloc.stream.listen((_) => notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    final mainUseCase = MainUseCase();
    return Navigator(
      key: navigatorKey,
      pages: [
        if (navigationBloc.state is MainScreenState)
/*
          const MaterialPage(
            child: BlocProvider(
                create: (context) => MainBloc(mainUsecase: mainUsecase),
                child: MainScreen()),
          ),
*/
        const MaterialPage(child: MainScreen()),
        if (navigationBloc.state is AuthScreenState)
          const MaterialPage(child: AuthScreen()),
      ],
      onDidRemovePage: (route) {
        //   TODO: обработать логику удаления страницы
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    //   TODO: добавить обработку нового маршрута
  }
}
