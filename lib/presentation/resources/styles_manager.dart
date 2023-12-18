import 'package:event_platform_app/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    overflow: TextOverflow.ellipsis,
  );
}

// small style
TextStyle getSmallStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

// Meduim Style
TextStyle getMeduimStyle({
  double fontSize = FontSize.s16,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

// large style
TextStyle getRegularStyle({
  double fontSize = FontSize.s20,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

TextStyle getlargeStyle({
  double fontSize = FontSize.s25,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

TextStyle getVerylargeStyle({
  double fontSize = FontSize.s30,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}
