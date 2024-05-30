import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeEvent {
  final ThemeMode themeMode;

  const ThemeChanged(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

class SeedColorChanged extends ThemeEvent {
  final Color seedColor;

  const SeedColorChanged(this.seedColor);

  @override
  List<Object> get props => [seedColor];
}
