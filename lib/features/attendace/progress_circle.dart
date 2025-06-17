import 'package:MySchool/core/constants/constants.dart';
import 'package:flutter/material.dart';

class ProgressCircle extends StatelessWidget {
  final double proggress;
  final double remaining;
  final double radiusFactor;
  final Color progressColor;
  final Color remainingColor;
  final double strokeWidth;
  final String centerText;

  const ProgressCircle({
    super.key,
    required this.proggress,
    required this.remaining,
    this.radiusFactor = 0.3,
    this.progressColor = AppColors.kSecondaryColor,
    this.remainingColor = const Color(0xFFC53F3F),
    this.strokeWidth = 10.0,
    this.centerText = '',
  });

  @override
  Widget build(BuildContext context) {
    final double proggressPercentage = (proggress * 100) / (remaining);
    // final double proggressPercentage = 100 - remaining;
    final double size = radiusFactor;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: strokeWidth,
              backgroundColor: Colors.grey[200],
              color: remainingColor,
            ),
          ),

          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: proggressPercentage / 100,
              strokeWidth: strokeWidth,
              backgroundColor: Colors.transparent,
              color: progressColor,
              strokeCap: StrokeCap.round,
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${proggressPercentage.toStringAsFixed(1)}%',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: size * 0.20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                centerText,
                style: TextStyle(
                  fontSize: size * 0.08,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
