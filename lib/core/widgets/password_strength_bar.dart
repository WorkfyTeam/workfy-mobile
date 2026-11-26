import 'package:material_ui/material_ui.dart';
import 'package:workbridge/core/theme/theme_extension.dart';

/// A reusable password strength indicator widget that tracks password complexity
/// (minimum length, numbers/symbols, uppercase and lowercase letters) in real-time.
class PasswordStrengthBar extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;

  const PasswordStrengthBar({
    super.key,
    required this.controller,
    this.labelText = 'Password Strength',
  });

  @override
  State<PasswordStrengthBar> createState() => _PasswordStrengthBarState();
}

class _PasswordStrengthBarState extends State<PasswordStrengthBar> {
  bool _hasMinLength = false;
  bool _hasNumberOrSymbol = false;
  bool _hasUpperAndLower = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validatePasswordRules);
    _validatePasswordRules();
  }

  @override
  void didUpdateWidget(covariant PasswordStrengthBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_validatePasswordRules);
      widget.controller.addListener(_validatePasswordRules);
      _validatePasswordRules();
    }
  }

  void _validatePasswordRules() {
    final text = widget.controller.text;
    setState(() {
      _hasMinLength = text.length >= 8;
      _hasNumberOrSymbol = RegExp(r'[0-9!@#$%^&*(),.?":{}|<>]').hasMatch(text);
      _hasUpperAndLower = RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(text);
    });
  }

  int get _strengthScore {
    int score = 0;
    if (widget.controller.text.isNotEmpty) score++;
    if (_hasMinLength) score++;
    if (_hasNumberOrSymbol) score++;
    if (_hasUpperAndLower) score++;
    return score;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validatePasswordRules);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(widget.labelText!, style: textTheme.labelMedium),
          const SizedBox(height: 6),
        ],

        // 4 Strength Bars
        Row(
          children: List.generate(4, (index) {
            final isFilled = index < _strengthScore;
            return Expanded(
              child: AnimatedContainer(
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
                height: 5,
                margin: EdgeInsets.only(right: index < 3 ? 6 : 0),
                decoration: BoxDecoration(
                  color: isFilled ? colors.tertiary : colors.outline.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 10),

        // 3 Rule Badges
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _buildRuleBadge("8+ characters", _hasMinLength),
            _buildRuleBadge("Contains number or symbol", _hasNumberOrSymbol),
            _buildRuleBadge("Upper & lower case", _hasUpperAndLower),
          ],
        ),
      ],
    );
  }

  Widget _buildRuleBadge(String text, bool isMet) {
    final colors = Theme.of(context).colorScheme;
    final palette = Theme.of(context).extension<WorkBridgeThemeExtension>()!;

    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isMet ? palette.matchBackground : colors.onInverseSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isMet) ...[
            Icon(
              Icons.check,
              size: 14,
              color: palette.matchForeground,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: isMet ? palette.matchForeground : colors.outline,
            ),
          ),
        ],
      ),
    );
  }
}
