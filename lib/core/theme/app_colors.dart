import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Backgrounds
  static const background = Color(0xFF020617);
  static const surface = Color(0xFF0F172A);
  static const surfaceElevated = Color(0xFF1E293B);

  // Borders
  static const border = Color(0xFF334155);

  // Text
  static const textPrimary = Color(0xFFE2E8F0);
  static const textSecondary = Color(0xFF94A3B8);

  // Brand / Accent
  static const accent = Color(0xFF22D3EE);
  static const success = Color(0xFF14B8A6);

  // Feature Colors
  static const pattern = Color(0xFF8B5CF6);
  static const note = Color(0xFFF472B6);
  static const favorite = Color(0xFFFFD54F);

  // Warnings / Errors
  static const securityWarning = Color(0xFFFF6B6B);

  // Base
  static const white = Colors.white;
  static const black = Colors.black;
  static const transparent = Colors.transparent;
}

class AppOpacity {
  AppOpacity._();

  // Surfaces
  static const double subtle = 0.05;
  static const double subtleStrong = 0.08;

	// overlay
	static const double overlay = 0.25;
  
	// Low Priority
  static const double metadata = 0.4;

  // Helper / Icons
  static const double secondary = 0.6;

  // Readable Secondary Text
  static const double readable = 0.68;

  // Main Content
  static const double body = 0.8;
}