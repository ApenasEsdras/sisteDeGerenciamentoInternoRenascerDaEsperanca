// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;
  // Avoid self isntance
  ColorsApp._();
  static ColorsApp get instance {
    _instance ??= ColorsApp._();
    return _instance!;
  }
  
  Color get Laranja => const Color.fromRGBO(246, 162, 0, 1);
  Color get Verde => const Color.fromRGBO(122, 199, 79, 1);
  Color get Vermelho => const Color.fromRGBO(231, 29, 54, 1);

  Color get CinzaEscuro => const Color.fromRGBO(69, 69, 69, 1);
  Color get CinzaMedio => const Color.fromRGBO(205, 205, 205, 1);
  Color get CinzaMedio2 => const Color.fromRGBO(69, 69, 69, 0.7);
  Color get CinzaClaro => const Color.fromRGBO(69, 69, 69, 0.1);

  Color get Branco => const Color.fromRGBO(253, 253, 253, 1);

  Color get Azul => const Color.fromRGBO(46, 134, 171, 1);
}

extension ColorsAppExceptions on BuildContext {
  ColorsApp get colors => ColorsApp.instance;
}
