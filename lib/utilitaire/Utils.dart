import 'package:flutter/material.dart';

class WidgetUtils {
  MediaQueryData _mediaQueryData;
  double _screenWidth;
  double _screenHeight;
  double _blockSizeHorizontal;
  double _blockSizeVertical;

  init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;
  }
}