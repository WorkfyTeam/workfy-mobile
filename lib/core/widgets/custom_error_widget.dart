import 'package:material_ui/material_ui.dart';
import 'package:workbridge/generated/l10n.dart';
import 'app_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onRetry;
  final String? retryText;
  final IconData icon;
  final bool isCard;
  final bool isCompact;
  final Widget? secondaryAction;
  final bool _isNetwork;

  const CustomErrorWidget({
    super.key,
    this.title,
    this.message,
    this.onRetry,
    this.retryText,
    this.icon = Icons.error_outline_rounded,
    this.isCard = false,
    this.isCompact = false,
    this.secondaryAction,
  }) : _isNetwork = false;

  const CustomErrorWidget.network({
    super.key,
    this.title,
    this.message,
    this.onRetry,
    this.retryText,
    this.isCard = false,
    this.isCompact = false,
    this.secondaryAction,
    this.icon = Icons.wifi_off_rounded,
  }) : _isNetwork = true;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final effectiveMessage = message ?? (_isNetwork ? l10n.networkError : l10n.serverError);
    final effectiveRetryText = retryText ?? l10n.retry;

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
                effectiveMessage,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium,
              ),
            ),
            if (onRetry != null || secondaryAction != null) ...[
              SizedBox(height: isCompact ? 16 : 24),
              if (onRetry != null)
                AppButton.primary(
                  text: effectiveRetryText,
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