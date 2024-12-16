import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/main/domain/usecases/main_usecase.dart';
import 'package:frontend/features/main/presentation/bloc/main_event.dart';
import 'package:frontend/features/main/presentation/bloc/main_state.dart';

import '../../domain/entities/Movie.dart';


class MainBloc extends Bloc<MainEvent, MainState> {
  final MainUseCase mainUsecase;

  MainBloc({required this.mainUsecase}) : super(MainInitialState()) {
    on<FetchMovieEvent>((event, emit) async {
      List<Movie> movies = await mainUsecase.getMovies();
      emit(MainLoadedState(movies));
    });
  }
}