// lib/widgets/common/custom_button.dart
import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary, outline, danger }

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final ButtonVariant variant;
  final Color? color;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.variant = ButtonVariant.primary,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = variant == ButtonVariant.primary;
    final Color primaryColor =
        color ?? const Color(0xFF000000); // Verde do Bytebank

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: isPrimary ? Colors.white : primaryColor,
        backgroundColor: isPrimary
            ? primaryColor
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: isPrimary
              ? BorderSide.none
              : BorderSide(color: primaryColor, width: 2),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
