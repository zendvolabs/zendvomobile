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

  static double getWidth(double percentage) => blockSizeHorizontal * percentage;

  static double getHeight(double percentage) => blockSizeVertical * percentage;

  static double getSafeWidth(double percentage) =>
      safeBlockSizeHorizontal * percentage;

  static double getSafeHeight(double percentage) =>
      safeBlockSizeVertical * percentage;
}
