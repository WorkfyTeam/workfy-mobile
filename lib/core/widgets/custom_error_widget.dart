import 'package:material_ui/material_ui.dart';
import 'app_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? title;
  final String message;
  final VoidCallback? onRetry;
  final String retryText;
  final IconData icon;
  final bool isCard;
  final bool isCompact;
  final Widget? secondaryAction;

  const CustomErrorWidget({
    super.key,
    this.title,
    required this.message,
    this.onRetry,
    this.retryText = 'إعادة المحاولة',
    this.icon = Icons.error_outline_rounded,
    this.isCard = false,
    this.isCompact = false,
    this.secondaryAction,
  });

  factory CustomErrorWidget.network({
    Key? key,
    String? title = 'تعذر الاتصال بالشبكة',
    String message = 'يرجى التحقق من اتصالك بالإنترنت ثم إعادة المحاولة',
    VoidCallback? onRetry,
    String retryText = 'إعادة المحاولة',
    bool isCard = false,
  }) {
    return CustomErrorWidget(
      key: key,
      title: title,
      message: message,
      onRetry: onRetry,
      retryText: retryText,
      icon: Icons.wifi_off_rounded,
      isCard: isCard,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final content = Padding(
      padding: EdgeInsets.all(isCompact ? 16.0 : 24.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: isCompact ? 52 : 64,
              height: isCompact ? 52 : 64,
              decoration: BoxDecoration(
                color: colors.errorContainer,
                shape: BoxShape.circle,
                border: Border.all(color: colors.error.withValues(alpha: 0.2), width: 1.5),
              ),
              child: Icon(icon, color: colors.error, size: isCompact ? 26 : 32),
            ),
            SizedBox(height: isCompact ? 12 : 16),
            if (title != null) ...[
              Text(
                title!,
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(fontSize: isCompact ? 15 : 16),
              ),
              const SizedBox(height: 6),
            ],
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium,
              ),
            ),
            if (onRetry != null || secondaryAction != null) ...[
              SizedBox(height: isCompact ? 16 : 24),
              if (onRetry != null)
                AppButton.primary(
                  text: retryText,
                  leadingIcon: const Icon(Icons.refresh_rounded, size: 18),
                  onPressed: onRetry,
                  width: isCompact ? double.infinity : 170,
                  height: isCompact ? 42 : 46,
                ),
              if (secondaryAction != null) ...[
                const SizedBox(height: 8),
                secondaryAction!,
              ],
            ],
          ],
        ),
      ),
    );

    if (isCard) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.outlineVariant, width: 1.0),
        ),
        child: content,
      );
    }

    return content;
  }
}