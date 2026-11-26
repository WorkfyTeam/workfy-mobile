import 'package:material_ui/material_ui.dart';
import 'package:workbridge/core/widgets/app_button.dart';
import 'package:workbridge/features/auth/presentation/pages/signup/widgets/path_option_card.dart';
import 'package:workbridge/generated/l10n.dart';

enum UserPath { work, hire }

class ChoosePathStep extends StatelessWidget {
  final UserPath? selectedPath;
  final ValueChanged<UserPath> onPathSelected;
  final VoidCallback onNext;

  const ChoosePathStep({super.key, required this.selectedPath, required this.onPathSelected, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = S.of(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.signupTitle2,
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // First Choice
          PathOptionCard(icon: Icons.person_outline_rounded, title: l10n.workPathTitle, subtitle: l10n.workPathSubtitle, isSelected: selectedPath == UserPath.work, onTap: () => onPathSelected(UserPath.work)),
          const SizedBox(height: 16),

          // Second Choice
          PathOptionCard(icon: Icons.apartment_rounded, title: l10n.hirePathTitle, subtitle: l10n.hirePathSubtitle, isSelected: selectedPath == UserPath.hire, onTap: () => onPathSelected(UserPath.hire)),
          const SizedBox(height: 32),

          // Continue
          AppButton.primary(text: l10n.nextSignupStep, trailingIcon: const Icon(Icons.arrow_right_alt_rounded, size: 25), onPressed: selectedPath != null ? onNext : null),
        ],
      ),
    );
  }
}

class ChoosePathScreen extends StatefulWidget {
  const ChoosePathScreen({super.key});

  @override
  State<ChoosePathScreen> createState() => _ChoosePathScreenState();
}

class _ChoosePathScreenState extends State<ChoosePathScreen> {
  UserPath? _selectedPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ChoosePathStep(selectedPath: _selectedPath, onPathSelected: (path) => setState(() => _selectedPath = path), onNext: () {}),
        ),
      ),
    );
  }
}
