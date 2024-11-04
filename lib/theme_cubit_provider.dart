import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/nav_bar/domain/theme_cubit.dart';

class ThemeCubitProvider extends StatelessWidget {
  final Widget child;

  const ThemeCubitProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (_) => ThemeCubit()..getSavedThemeMode(),
      child: child,
    );
  }

  static ThemeCubit of(BuildContext context) => BlocProvider.of<ThemeCubit>(context);
}
