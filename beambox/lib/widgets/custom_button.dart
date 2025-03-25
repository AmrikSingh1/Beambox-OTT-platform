import 'package:flutter/material.dart';
import '../config/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isLoading;
  final IconData? icon;
  final Widget? iconWidget;
  final double width;
  final Gradient? gradient;
  final Color? backgroundColor;
  final Color? textColor;
  
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
    this.icon,
    this.iconWidget,
    this.width = double.infinity,
    this.gradient,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? (isPrimary ? AppTheme.primaryColor : AppTheme.surfaceColor);
    final fgColor = textColor ?? (isPrimary ? Colors.white : AppTheme.textSecondary);
    
    // If gradient is provided, use a Container with gradient
    if (gradient != null) {
      return SizedBox(
        width: width,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLoading ? null : onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Ink(
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: isPrimary ? AppTheme.primaryShadow : null,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: _buildButtonContent(fgColor),
              ),
            ),
          ),
        ),
      );
    }
    
    // Regular button without gradient
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: isPrimary ? 2 : 0,
        ),
        child: _buildButtonContent(fgColor),
      ),
    );
  }
  
  Widget _buildButtonContent(Color foregroundColor) {
    return isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: 8),
              ],
              if (iconWidget != null) ...[
                iconWidget!,
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: foregroundColor,
                ),
              ),
            ],
          );
  }
} 