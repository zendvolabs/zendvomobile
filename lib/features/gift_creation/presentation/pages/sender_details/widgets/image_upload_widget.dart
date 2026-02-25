import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/constants/app_spacing.dart';

class ImageUploadWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ImageUploadWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.uploadImageLabel,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.getBodyTextColor(context),
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        GestureDetector(
          onTap: onTap,
          child: CustomPaint(
            painter: _DashedBorderPainter(
              color: AppColors.getInactiveBorderColor(context),
              strokeWidth: 1.5,
              gap: 6.0,
              radius: AppSpacing.borderRadius,
            ),
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.getFieldBackgroundColor(context),
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: CustomPaint(
                      painter: _DashedBorderPainter(
                        color: AppColors.primary,
                        strokeWidth: 1.0,
                        gap: 3.0,
                        isCircle: true,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.m),
                  Text(
                    AppStrings.tapToUpload,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.getHeadingTextColor(context),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.maxImageSize,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.getBodyTextColor(
                        context,
                      ).withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double radius;
  final bool isCircle;

  _DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
    this.radius = 0.0,
    this.isCircle = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    if (isCircle) {
      _drawDashedCircle(canvas, size, paint);
    } else {
      _drawDashedRRect(canvas, size, paint);
    }
  }

  void _drawDashedRRect(Canvas canvas, Size size, Paint paint) {
    var path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    Path dashPath = _createDashedPath(path, dashLength: gap, dashGap: gap);
    canvas.drawPath(dashPath, paint);
  }

  void _drawDashedCircle(Canvas canvas, Size size, Paint paint) {
    var path = Path()..addOval(Rect.fromLTWH(0, 0, size.width, size.height));

    Path dashPath = _createDashedPath(path, dashLength: gap, dashGap: gap);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(
    Path source, {
    required double dashLength,
    required double dashGap,
  }) {
    final dest = Path();
    for (final metric in source.computeMetrics()) {
      var distance = 0.0;
      var draw = true;
      while (distance < metric.length) {
        final len = draw ? dashLength : dashGap;
        if (draw) {
          dest.addPath(
            metric.extractPath(distance, distance + len),
            Offset.zero,
          );
        }
        distance += len;
        draw = !draw;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
