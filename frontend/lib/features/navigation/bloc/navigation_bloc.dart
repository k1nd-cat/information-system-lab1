import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/navigation/bloc/navigation_event.dart';
import 'package:frontend/features/navigation/bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(MainScreenState()) {
    on<NavigateToAuth>((event, emit) => emit(AuthScreenState()));

    on<NavigateToMain>((event, emit) => emit(MainScreenState()));
  }
}
