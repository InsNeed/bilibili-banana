// theme_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/daily_news/presentatsion/bloc/theme/bloc/theme_state.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState()) {
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  @override
  void _onToggleTheme(
      ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    final ThemeState newThemeData =
        state is LightThemeState ? DarkThemeState() : LightThemeState();
    emit(newThemeData);
  }
}

