import 'package:flutter/material.dart';
import 'package:sistemarenascerdaesperanca/src/styles/colors_app.dart';

class InputDecorationUtils {
  static InputDecoration getCustomInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        fontFamily: 'roboto',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ColorsApp.instance.CinzaEscuro,
      ),
      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
        (Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.focused)
              ? ColorsApp.instance.Laranja
              : ColorsApp.instance.CinzaMedio2;
          return TextStyle(color: color);
        },
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorsApp.instance.Laranja,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.8,
          color: ColorsApp.instance.CinzaMedio,
        ),
      ),
    );
  }
}
