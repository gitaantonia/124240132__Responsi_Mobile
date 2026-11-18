import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SafeImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final IconData placeholderIcon;

  const SafeImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderIcon = Icons.videogame_asset,
  });

  static String formatUrl(String? url) {
    if (url == null || url.trim().isEmpty) return '';
    final clean = url.trim();
    if (kIsWeb) {
      return 'https://images.weserv.nl/?url=${Uri.encodeComponent(clean)}';
    }
    return clean;
  }

  static String fallbackUrl(String? url) {
    if (url == null || url.trim().isEmpty) return '';
    return 'https://images.weserv.nl/?url=${Uri.encodeComponent(url.trim())}';
  }

  @override
  Widget build(BuildContext context) {
    final cleanUrl = imageUrl.trim();
    if (cleanUrl.isEmpty) {
      return _buildPlaceholder();
    }

    final targetUrl = formatUrl(cleanUrl);
    final backupUrl = fallbackUrl(cleanUrl);

    Widget image = Image.network(
      targetUrl,
      width: width,
      height: height,
      fit: fit,
      headers: const {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width,
          height: height,
          color: const Color(0xFF141414),
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFF2979FF),
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        if (targetUrl != backupUrl) {
          return Image.network(
            backupUrl,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
          );
        }
        return _buildPlaceholder();
      },
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }

    return image;
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: const Color(0xFF1E1E1E),
      child: Center(
        child: Icon(placeholderIcon, color: Colors.grey[700], size: 28),
      ),
    );
  }
}
