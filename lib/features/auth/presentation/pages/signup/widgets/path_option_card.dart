import 'package:material_ui/material_ui.dart';

class PathOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const PathOptionCard({super.key, required this.icon, required this.title, required this.subtitle, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 45),
        decoration: BoxDecoration(
          color: isSelected ? colors.surfaceContainer : colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? colors.primary : colors.outlineVariant, width: isSelected ? 1.5 : 1.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: colors.primary),
            const SizedBox(height: 12),
            Text(title, style: textTheme.headlineSmall, textAlign: TextAlign.center),
            const SizedBox(height: 6),
            Text(subtitle, textAlign: TextAlign.center, style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
