import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockSizeHorizontal;
  static late double safeBlockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockSizeHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockSizeVertical = (screenHeight - _safeAreaVertical) / 100;
  }

  // Get responsive width
  static double getWidth(double percentage) => blockSizeHorizontal * percentage;

  // Get responsive height
  static double getHeight(double percentage) => blockSizeVertical * percentage;

  // Get safe area responsive width
  static double getSafeWidth(double percentage) =>
      safeBlockSizeHorizontal * percentage;

  // Get safe area responsive height
  static double getSafeHeight(double percentage) =>
      safeBlockSizeVertical * percentage;
}
