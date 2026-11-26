import 'package:material_ui/material_ui.dart';
import 'package:workbridge/core/widgets/app_button.dart';
import 'package:workbridge/core/widgets/app_text_field.dart';
import 'package:workbridge/generated/l10n.dart';

class NameStep extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final VoidCallback onSubmit;
  final bool isLoading;

  const NameStep({super.key, required this.firstNameController, required this.lastNameController, required this.onSubmit, this.isLoading = false});

  @override
  State<NameStep> createState() => _NameStepState();
}

class _NameStepState extends State<NameStep> {
  final _stepFormKey = GlobalKey<FormState>();

  String? _validateName(String? value, S l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.errorFieldIsEmpty;
    }
    final trimmed = value.trim();
    if (trimmed.length < 2) {
      return l10n.errorNameField;
    }
    // Allows Arabic letters, English letters, spaces, hyphens, and apostrophes
    final nameRegex = RegExp(r"^[\u0621-\u064Aa-zA-Z\s\-']+$");

    if (!nameRegex.hasMatch(trimmed)) {
      return l10n.errorNameField;
    }
    return null;
  }

  void _handleSubmit() {
    FocusScope.of(context).unfocus();
    if (_stepFormKey.currentState!.validate()) {
      widget.onSubmit();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = S.of(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Form(
        key: _stepFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.whatWeCallYouSignup,
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 36),
            AppTextField(controller: widget.firstNameController, label: l10n.firstName, hint: l10n.yourFirstName, isRequired: true, enabled: !widget.isLoading, keyboardType: TextInputType.name, textInputAction: TextInputAction.next, validator: (value) => _validateName(value, l10n)),
            const SizedBox(height: 24),
            AppTextField(controller: widget.lastNameController, label: l10n.lastName, hint: l10n.yourLastName, isRequired: true, enabled: !widget.isLoading, keyboardType: TextInputType.name, textInputAction: TextInputAction.next, validator: (value) => _validateName(value, l10n)),

            const SizedBox(height: 36),
            AppButton.primary(text: l10n.signup, trailingIcon: const Icon(Icons.arrow_forward_rounded), isLoading: widget.isLoading, onPressed: _handleSubmit, height: 50),
          ],
        ),
      ),
    );
  }
}
