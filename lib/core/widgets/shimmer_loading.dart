import 'package:flutter/material.dart';
import 'package:workbridge/core/theme/theme_extension.dart';

class Shimmer extends StatefulWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration duration;
  final bool enabled;

  const Shimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1400),
    this.enabled = true,
  });

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final palette = theme.extension<WorkBridgeThemeExtension>()!;
    final isDark = theme.brightness == Brightness.dark;

    if (!widget.enabled) return widget.child;

    final base = widget.baseColor ?? palette.tagBackground;
    final highlight = widget.highlightColor ?? (isDark ? colors.surfaceContainerHighest : colors.surface);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [base, highlight, base],
              stops: const [0.1, 0.45, 0.9],
              transform: _SlidingGradientTransform(slidePercent: _controller.value),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * (slidePercent * 2 - 1), 0.0, 0.0);
  }
}

class ShimmerBox extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;
  final Color? color;
  final ShapeBorder? shape;

  const ShimmerBox({
    super.key,
    this.width,
    required this.height,
    this.borderRadius = 8.0,
    this.color,
    this.shape,
  });

  const ShimmerBox.circle({super.key, required double size, this.color})
      : width = size,
        height = size,
        borderRadius = 9999,
        shape = const CircleBorder();

  const ShimmerBox.pill({super.key, this.width, required this.height, this.color})
      : borderRadius = 9999,
        shape = const StadiumBorder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: color ?? Theme.of(context).extension<WorkBridgeThemeExtension>()!.tagBackground,
        shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      ),
    );
  }
}

class JobCardSkeleton extends StatelessWidget {
  const JobCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant, width: 1.0),
      ),
      child: Shimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(width: 48, height: 48, borderRadius: 12),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(width: 150, height: 16, borderRadius: 4),
                      SizedBox(height: 8),
                      ShimmerBox(width: 95, height: 12, borderRadius: 4),
                    ],
                  ),
                ),
                ShimmerBox(width: 32, height: 32, borderRadius: 8),
              ],
            ),
            const SizedBox(height: 14),
            const Row(
              children: [
                ShimmerBox.pill(width: 84, height: 22),
                SizedBox(width: 10),
                ShimmerBox(width: 110, height: 14, borderRadius: 4),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                ShimmerBox(width: 74, height: 12, borderRadius: 4),
                SizedBox(width: 14),
                ShimmerBox(width: 68, height: 12, borderRadius: 4),
                SizedBox(width: 14),
                ShimmerBox(width: 55, height: 12, borderRadius: 4),
              ],
            ),
            const SizedBox(height: 14),
            Container(height: 1.0, color: colors.outlineVariant),
            const SizedBox(height: 12),
            const Row(
              children: [
                ShimmerBox.pill(width: 60, height: 24),
                SizedBox(width: 8),
                ShimmerBox.pill(width: 72, height: 24),
                SizedBox(width: 8),
                ShimmerBox.pill(width: 54, height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ContractAgreementSkeleton extends StatelessWidget {
  const ContractAgreementSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final palette = Theme.of(context).extension<WorkBridgeThemeExtension>()!;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Shimmer(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.outlineVariant),
              ),
              child: const Row(
                children: [
                  ShimmerBox.circle(size: 32),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(width: 110, height: 14, borderRadius: 4),
                      SizedBox(height: 6),
                      ShimmerBox(width: 190, height: 11, borderRadius: 4),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerBox(width: 100, height: 12, borderRadius: 4),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: palette.tagBackground,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerBox(width: 50, height: 10),
                              SizedBox(height: 8),
                              ShimmerBox(width: 36, height: 36, borderRadius: 8),
                              SizedBox(height: 8),
                              ShimmerBox(width: 75, height: 12),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: palette.tagBackground,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerBox(width: 50, height: 10),
                              SizedBox(height: 8),
                              ShimmerBox.circle(size: 36),
                              SizedBox(height: 8),
                              ShimmerBox(width: 75, height: 12),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.outlineVariant),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerBox(width: 120, height: 12),
                      ShimmerBox.pill(width: 90, height: 20),
                    ],
                  ),
                  SizedBox(height: 12),
                  ShimmerBox(width: 140, height: 28, borderRadius: 4),
                  SizedBox(height: 10),
                  ShimmerBox(width: double.infinity, height: 12),
                  SizedBox(height: 6),
                  ShimmerBox(width: 220, height: 12),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.outlineVariant),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 140, height: 14),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: ShimmerBox(height: 52, borderRadius: 12)),
                      SizedBox(width: 10),
                      Expanded(child: ShimmerBox(height: 52, borderRadius: 12)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: ShimmerBox(height: 52, borderRadius: 12)),
                      SizedBox(width: 10),
                      Expanded(child: ShimmerBox(height: 52, borderRadius: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}