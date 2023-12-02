import 'package:flutter/material.dart';

class TextStyles {
  static TextStyles? _instance;

  TextStyles._();

  static TextStyles get instance {
    _instance ??= TextStyles._();
    return _instance!;
  }

  String get fontFamily => 'roboto';

  TextStyle get textRegular =>
      TextStyle(fontWeight: FontWeight.w400, fontFamily: fontFamily);

  TextStyle get textMedium =>
      TextStyle(fontWeight: FontWeight.w500, fontFamily: fontFamily);


  TextStyle get textMedium16 => textMedium.copyWith(fontSize: 16);
  TextStyle get textMedium20 => textMedium.copyWith(fontSize: 20);
  TextStyle get textRegular12 => textRegular.copyWith(fontSize: 12);
}

extension TextStylesExtensions on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}
