import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenesisTextTheme {
  GenesisTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 36.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.0,
        color: Colors.black),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        color: Colors.black),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        color: Colors.black.withOpacity(0.5)),
    titleLarge: const TextStyle().copyWith(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        color: Colors.black),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: Colors.black),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: Colors.black),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: Colors.black),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: Colors.black),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: Colors.black.withOpacity(0.5)),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: Colors.black),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: Colors.black),
    labelSmall: const TextStyle().copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.0,
        color: Colors.black.withOpacity(0.5)),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 36.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.0,
        color: Colors.white),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        color: Colors.white),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        color: Colors.white.withOpacity(0.5)),
    titleLarge: const TextStyle().copyWith(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        color: Colors.white),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: Colors.white),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: Colors.white),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: Colors.white),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: Colors.white),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: Colors.white.withOpacity(0.5)),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: Colors.white),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: Colors.white),
    labelSmall: const TextStyle().copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: Colors.white.withOpacity(0.5)),
  );
}
