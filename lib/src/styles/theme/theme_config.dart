import 'package:flutter/material.dart';
import '../app_styles.dart';
import '../colors_app.dart';
import '../text_styles.dart';

class ThemeConfig {
  ThemeConfig._();

  static final _defultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: ColorsApp.instance.CinzaMedio),
  );

  static final theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsApp.instance.Laranja,
      primary: ColorsApp.instance.Laranja,
      secondary: ColorsApp.instance.CinzaClaro,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyles.instance.primaryButton,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorsApp.instance.Branco,
      filled: true,
      isDense: true,
      iconColor: ColorsApp.instance.CinzaEscuro,
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: _defultInputBorder,
      focusedBorder: _defultInputBorder,
      labelStyle: TextStyles.instance.textRegular
          .copyWith(color: ColorsApp.instance.CinzaEscuro),
      errorStyle:
          TextStyles.instance.textRegular.copyWith(color: const Color.fromARGB(255, 19, 184, 234)),
    ),
  );
}
