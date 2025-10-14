import 'package:flutter/material.dart';
import '../Themes/app_colors_theme.dart';

class ImageUtils {
  /// Safe network image with comprehensive error handling
  static Widget safeNetworkImage({
    required String imageUrl,
    required Widget fallbackWidget,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Color? loadingColor,
    double loadingStrokeWidth = 2.0,
  }) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        
        return Container(
          width: width,
          height: height,
          color: (loadingColor ?? AppColor.primaryColor).withValues(alpha: 0.1),
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
              strokeWidth: loadingStrokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(
                loadingColor ?? AppColor.primaryColor,
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        print('🖼️ Network image load error for URL: $imageUrl');
        print('🖼️ Error details: $error');
        return fallbackWidget;
      },
    );
  }

  /// Check if image URL is valid
  static bool isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    
    // Check for problematic URLs
    if (url.contains('cloudflarestorage.com') || 
        url.contains('exercises.c4f683a2d4dd475571f288c338a76b19.r2.cloudflarestorage.com')) {
      print('🚫 Blocked problematic URL: $url');
      return false;
    }
    
    // Check for common image extensions
    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp'];
    final lowerUrl = url.toLowerCase();
    
    return imageExtensions.any((ext) => lowerUrl.contains(ext)) ||
           lowerUrl.contains('image') ||
           lowerUrl.contains('photo');
  }

  /// Get fallback avatar widget
  static Widget getFallbackAvatar({
    required String name,
    double size = 60.0,
    Color? backgroundColor,
    Color? textColor,
  }) {
    final bgColor = backgroundColor ?? AppColor.primaryColor;
    final txtColor = textColor ?? Colors.white;
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            bgColor,
            bgColor.withValues(alpha: 0.7),
          ],
        ),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : "A",
          style: TextStyle(
            color: txtColor,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
