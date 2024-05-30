import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final Color seedColor;

  const ThemeState({required this.themeMode, required this.seedColor});

  ThemeState copyWith({ThemeMode? themeMode, Color? seedColor}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      seedColor: seedColor ?? this.seedColor,
    );
  }

  @override
  List<Object> get props => [themeMode, seedColor];
}
