import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:time_ledger/features/user/presentation/bloc/theme_event.dart';
import 'package:time_ledger/features/user/presentation/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(const ThemeState(
            themeMode: ThemeMode.system, seedColor: Color(0xfD7EC79))) {
    on<ThemeChanged>(_onThemeChanged);
    on<SeedColorChanged>(_onSeedColorChanged);
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeMode: event.themeMode));
  }

  void _onSeedColorChanged(SeedColorChanged event, Emitter<ThemeState> emit) {
    emit(state.copyWith(seedColor: event.seedColor));
  }
}
