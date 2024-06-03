import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_utils.dart';
import 'custom_tab.dart';

/// https://mp.weixin.qq.com/s/SIEYjZn0gKNMCGlPeg1rGw

ThemeData themeData = ThemeData(
    useMaterial3: true,
    shadowColor: const Color(0xff003890).withOpacity(.07),
    iconTheme: const IconThemeData(color: ColorUtil.color_333333),
    hintColor: ColorUtil.color_999999,
    dividerTheme: const DividerThemeData(color: Color(0xffeeeeee)),
    dividerColor: const Color(0xffeeeeee),
    cardColor: Colors.white,
    textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 18.sp, color: ColorUtil.color_333333, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(fontSize: 18.sp, color: ColorUtil.color_333333, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(fontSize: 16.sp, color: ColorUtil.color_333333, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(fontSize: 16.sp, color: ColorUtil.color_333333, fontWeight: FontWeight.normal),
        bodyMedium: TextStyle(fontSize: 14.sp, color: ColorUtil.color_333333, fontWeight: FontWeight.normal),
        bodySmall: TextStyle(fontSize: 10.sp, color: ColorUtil.color_999999)),
    cupertinoOverrideTheme:
        const CupertinoThemeData(brightness: Brightness.light, scaffoldBackgroundColor: Color(0xffF4F8FF)),
    secondaryHeaderColor: const Color(0xFFFBCF03),
    scaffoldBackgroundColor: const Color(0xffF4F8FF),
    primaryColor: const Color(0xff0063BF),
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff0063BF),
        brightness: Brightness.light,
        surface: Colors.white,
        outlineVariant: const Color(0xffeeeeee),
        surfaceTint: Colors.transparent),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xff0063BF), foregroundColor: Color(0xff0063BF), shape: CircleBorder()),
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.w500),
        iconTheme: const IconThemeData(color: Colors.black, size: 24.0)),
    tabBarTheme: TabBarTheme(
        dividerColor: Colors.transparent,
        labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        unselectedLabelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        labelColor: const Color(0xff0063BF),
        unselectedLabelColor: ColorUtil.color_999999,
        indicator: CustomTabIndicator(borderSide: BorderSide(width: 2.w, color: const Color(0xff0063BF))),
        tabAlignment: TabAlignment.start),
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: ColorUtil.color_999999, fontSize: 16.sp, height: 1.5), border: InputBorder.none),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        unselectedItemColor: Color(0xffC1C1C1),
        unselectedLabelStyle: TextStyle(color: Color(0xffC1C1C1), fontSize: 12),
        selectedLabelStyle: TextStyle(fontSize: 12),
        backgroundColor: Color(0xffF8FDFB),
        showUnselectedLabels: true,
        elevation: 25,
        type: BottomNavigationBarType.fixed));

ThemeData darkThemeData = ThemeData(
    useMaterial3: true,
    shadowColor: const Color(0xff003890).withOpacity(.07),
    iconTheme: const IconThemeData(color: Colors.white),
    hintColor: ColorUtil.color_999999,
    dividerTheme: const DividerThemeData(color: Color(0xff484d59)),
    dividerColor: const Color(0xff484d59),
    cardColor: Colors.grey[800],
    textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.normal),
        bodyMedium: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.normal),
        bodySmall: TextStyle(fontSize: 10.sp, color: ColorUtil.color_999999)),
    cupertinoOverrideTheme:
        const CupertinoThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: ColorUtil.color_333333),
    secondaryHeaderColor: const Color(0xFFFBCF03),
    scaffoldBackgroundColor: ColorUtil.color_333333,
    primaryColor: const Color(0xff0063BF),
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff0063BF),
        brightness: Brightness.dark,
        surface: Colors.grey[800],
        outlineVariant: ColorUtil.color_333333,
        surfaceTint: Colors.transparent),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xff0063BF), foregroundColor: Color(0xff0063BF), shape: CircleBorder()),
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        backgroundColor: const Color(0xff222222),
        foregroundColor: const Color(0xff222222),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w500),
        iconTheme: const IconThemeData(color: Colors.white, size: 24.0)),
    tabBarTheme: TabBarTheme(
        dividerColor: Colors.transparent,
        labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        unselectedLabelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        labelColor: const Color(0xff0063BF),
        unselectedLabelColor: ColorUtil.color_999999,
        indicator: CustomTabIndicator(borderSide: BorderSide(width: 2.w, color: const Color(0xff0063BF))),
        tabAlignment: TabAlignment.start),
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: ColorUtil.color_999999, fontSize: 16.sp, height: 1.5), border: InputBorder.none),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        unselectedItemColor: Color(0xffC1C1C1),
        unselectedLabelStyle: TextStyle(color: Color(0xffC1C1C1), fontSize: 12),
        selectedLabelStyle: TextStyle(fontSize: 12),
        backgroundColor: Color(0xff171717),
        showUnselectedLabels: true,
        elevation: 25,
        type: BottomNavigationBarType.fixed));
