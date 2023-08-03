part of '../import/app_import.dart';

class AppDime {
  static double base = 2;
  static double xs = base; // 2.0

  static double sm = xs * base; // 4.0

  static double md = sm * base; // 8.0

  static double lg = md * base; // 16.0

  static double xlg = lg * base; // 32.0

  static double xxl = xlg * base; // 64.0

  static double xxl_8 = xxl * one_25; // 80
  static double xxl_9 = xxl * one_41; // 90
  static double xxl_1 = xxl * one_57; // 100

  static double xxxi = xxl * base; // 128.0

  static double one_25 = 1.25;
  static double one_41 = 1.41;
  static double one_57 = 1.57;

  static double half = 0.5;
  static double quarter = 0.25;
  static double third = 0.35;
  static double fullScreen = 1;
  static double heightBtn = xxl; // 64
}
