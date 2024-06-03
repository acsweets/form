import 'dart:math';

import 'package:flutter/material.dart';

class ColorUtil {
  static const String BASIC_COLOR_RED = 'red';
  static const String BASIC_COLOR_GREEN = 'green';
  static const String BASIC_COLOR_BLUE = 'blue';
  static const String HEX_BLACK = '#000000';
  static const String HEX_WHITE = '#FFFFFF';

  static int parseColor(String? color) {
    if (color == null || color.isEmpty) {
      return 0xFFFFFFF;
    }
    color = color.replaceAll('#', '').trim();
    if (color.length == 8) {
      return int.parse('0x$color');
    } else {
      return int.parse('0xFF$color');
    }
  }

  static const Color color_999999 = Color(0xff999999);
  static const Color color_666666 = Color(0xff666666);
  static const Color color_333333 = Color(0xff333333);
  static const Color themeGreenColor = Color(0xff1BCF8A);
  static const Color themeBgColor = Color(0xffF8FDFB);

  static const Color lineColor = Color(0xffEAEAEA);
  static const Color grayColor = Color(0xffC1C1C1);
  static const Color deleteIconColor = Color(0xffFB6B34);

  //设置颜色
  static Color getColor(String? value) {
    if (null == value || value == "") {
      return Colors.transparent;
    }
    var color = '0xFF$value';
    return Color(int.parse(color));
  }

  static int getBgColorFromIndex(int number) {
    switch (number) {
      case 0:
        return 0xffCFECFF;
      case 1:
        return 0xffDAF6F4;
      case 2:
        return 0xffFEE1DD;
      case 3:
        return 0xffFDF1DB;
      default:
        return 0xffCFECFF;
    }
  }

  static int getTextMinColorFromIndex(int number) {
    switch (number) {
      case 0:
        return 0xff639BB2;
      case 1:
        return 0xff7DB1AC;
      case 2:
        return 0xffCFA09C;
      case 3:
        return 0xffD5BF97;
      default:
        return 0xff639BB2;
    }
  }

  //bct颜色
  static const Color themeBlueColor = Color(0xff03ABFB);
  static const Color themeYellowColor = Color(0xffFBCF03);
  static const Color lightYellowColor = Color(0xffFDE781);
  static const Color lightOrangeColor = Color(0xffFDA981);
  static const Color lightRedColor = Color(0xffFB5303);

  //hsk
  static const Color deepBlueColor = Color(0xff1BBACF);
  static const Color deepOrangeColor = Color(0xffCF8A1B);
  static const Color redColor = Color(0xffFB6157);
  static const Color deepRedColor = Color(0xffCF301B);



  /// 获取练习题答案对应颜色
  ///
  /// [isRight] 答案是否正确
  ///
  /// return isRight ? Color(0xff1BCF8A) : Color(0xffFc4848);
  ///
  static Color getPracticeColor(bool isRight) {
    if (isRight) {
      return const Color(0xff1BCF8A);
    } else {
      return const Color(0xffFc4848);
    }
  }

  ///
  /// Converts the given [hex] color string to the corresponding int
  ///
  static int hexToInt(String hex) {
    if (hex.startsWith('#')) {
      hex = hex.replaceFirst('#', 'FF');
      return int.parse(hex, radix: 16);
    } else {
      if (hex.length == 6) {
        hex = 'FF$hex';
      }
      return int.parse(hex, radix: 16);
    }
  }

  ///
  /// Converts the given integer [i] to a hex string with a leading #.
  ///
  static String intToHex(int i) {
    var s = i.toRadixString(16);
    if (s.length == 8) {
      return '#${s.substring(2).toUpperCase()}';
    } else {
      return '#${s.toUpperCase()}';
    }
  }

  ///
  /// Lightens or darkens the given [hex] color by the given [percent].
  ///
  /// To lighten a color, set the [percent] value to > 0.
  /// To darken a color, set the [percent] value to < 0.
  /// Will add a # to the [hex] string if it is missing.
  ///
  ///
  static String shadeColor(String hex, double percent) {
    var bC = basicColorsFromHex(hex);

    var R = (bC[BASIC_COLOR_RED]! * (100 + percent) / 100).round();
    var G = (bC[BASIC_COLOR_GREEN]! * (100 + percent) / 100).round();
    var B = (bC[BASIC_COLOR_BLUE]! * (100 + percent) / 100).round();

    if (R > 255) {
      R = 255;
    } else if (R < 0) {
      R = 0;
    }

    if (G > 255) {
      G = 255;
    } else if (G < 0) {
      G = 0;
    }

    if (B > 255) {
      B = 255;
    } else if (B < 0) {
      B = 0;
    }

    var RR = (R.toRadixString(16).length == 1) ? '0${R.toRadixString(16)}' : R.toRadixString(16);
    var GG = (G.toRadixString(16).length == 1) ? '0${G.toRadixString(16)}' : G.toRadixString(16);
    var BB = (B.toRadixString(16).length == 1) ? '0${B.toRadixString(16)}' : B.toRadixString(16);

    return '#$RR$GG$BB';
  }

  ///
  /// Fills up the given 3 char [hex] string to 6 char hex string.
  ///
  /// Will add a # to the [hex] string if it is missing.
  ///
  static String fillUpHex(String hex) {
    if (!hex.startsWith('#')) {
      hex = '#$hex';
    }

    if (hex.length == 7) {
      return hex;
    }

    var filledUp = '';
    for (var r in hex.runes) {
      var char = String.fromCharCode(r);
      if (char == '#') {
        filledUp = filledUp + char;
      } else {
        filledUp = filledUp + char + char;
      }
    }
    return filledUp;
  }


  ///
  /// Fetches the basic color int values for red, green, blue from the given [hex] string.
  ///
  /// The values are returned inside a map with the following keys :
  /// * red
  /// * green
  /// * blue
  ///
  static Map<String, int> basicColorsFromHex(String hex) {
    hex = fillUpHex(hex);

    if (!hex.startsWith('#')) {
      hex = '#$hex';
    }

    var R = int.parse(hex.substring(1, 3), radix: 16);
    var G = int.parse(hex.substring(3, 5), radix: 16);
    var B = int.parse(hex.substring(5, 7), radix: 16);
    return {BASIC_COLOR_RED: R, BASIC_COLOR_GREEN: G, BASIC_COLOR_BLUE: B};
  }

  ///
  /// Swatch the given [hex] color.
  ///
  /// It creates lighter and darker colors from the given [hex] returned in a list with the given [hex].
  ///
  /// The [amount] defines how much lighter or darker colors a generated.
  /// The specified [percentage] value defines the color spacing of the individual colors. As a default,
  /// each color is 15 percent lighter or darker than the previous one.
  ///
  static List<String> swatchColor(String hex, {double percentage = 15, int amount = 5}) {
    hex = fillUpHex(hex);

    var colors = <String>[];
    for (var i = 1; i <= amount; i++) {
      colors.add(shadeColor(hex, (6 - i) * percentage));
    }
    colors.add(hex);
    for (var i = 1; i <= amount; i++) {
      colors.add(shadeColor(hex, (0 - i) * percentage));
    }
    return colors;
  }

  /// 根据HSK等级得到对应的颜色
  static Color getLevelColor(int level) {
    switch (level) {
      case 1:
        return const Color(0xffF8B51E);
      case 2:
        return const Color(0xff25A6C4);
      case 3:
        return const Color(0xffED6E07);
      case 4:
        return const Color(0xffBB1019);
      case 5:
        return const Color(0xff2F78E3);
      case 6:
        return const Color(0xffAA50A8);
      default:
        return const Color(0xff57C28E);
    }
  }

  static Color getRankingColor(int index, {Color? defaultColor}) {
    switch (index) {
      case 0:
        return const Color(0xffFF6450);
      case 1:
        return const Color(0xffFFB250);
      case 2:
        return const Color(0xff50CBFF);
      default:
        return defaultColor ?? const Color(0xff888888);
    }
  }

  /// 字符串转颜色
  ///
  /// [string] 字符串
  ///
  static Color strToColor(String string) {
    final int hash = string.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  /// 随机颜色
  ///
  static Color randomRGB() {
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255));
  }

  static Color randomARGB() {
    Random random = Random();
    return Color.fromARGB(random.nextInt(180), random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }

  static List<Color> colors = const [
    Colors.orange,
    Colors.pink,
    Color(0xff50CBFF),
    Colors.deepOrangeAccent,
    Color(0xff57C28E),
    Color(0xffAA50A8),
    Color(0xff2F78E3),
    Color(0xffBB1019),
    Color(0xffFDA981),
    Colors.lightBlue,
    Colors.redAccent,
    Colors.red,
    Colors.yellow,
    Colors.deepPurpleAccent,
    Colors.brown,
    Colors.teal,
    Colors.green,
    Colors.lightGreenAccent,
    Colors.tealAccent,
    Colors.blue,
    Colors.blueGrey,
    Colors.greenAccent,
    Colors.lightGreen,
    Colors.deepPurple,
  ];


  ///HSVColor类,修改颜色的色相(Hue)、饱和度(Saturation)和值(Value)分量。让当前颜色更亮
  static Color brighterColor(Color color) {
    HSVColor hsv = HSVColor.fromColor(color);
    double lighterValue = hsv.value * 1.3 ;
    if (lighterValue > 1.0) {
      lighterValue = 1.0;
    }
    HSVColor lighterHSV = HSVColor.fromAHSV(hsv.alpha, hsv.hue, hsv.saturation, lighterValue);
    Color lighterColor = lighterHSV.toColor();
    return lighterColor;
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
