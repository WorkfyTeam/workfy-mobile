import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:workbridge/core/widgets/app_button.dart';
import 'package:workbridge/core/widgets/app_text_field.dart';
import 'package:workbridge/core/widgets/password_strength_bar.dart';
import 'package:workbridge/generated/l10n.dart';

class EmailPasswordStep extends StatefulWidget {
  final TextEditingController phoneOrEmailController;
  final TextEditingController passwordController;
  final VoidCallback onNext;
  final bool isLoading;

  const EmailPasswordStep({super.key, required this.phoneOrEmailController, required this.passwordController, required this.onNext, this.isLoading = false});

  @override
  State<EmailPasswordStep> createState() => _EmailPasswordStepState();
}

class _EmailPasswordStepState extends State<EmailPasswordStep> {
  final _stepFormKey = GlobalKey<FormState>();

  String? _validatePhoneOrEmail(String? value, S l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.errorFieldIsEmpty;
    }
    final trimmed = value.trim();
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^(01[0125]\d{8}|\+?201[0125]\d{8})$');

    if (!emailRegex.hasMatch(trimmed) && !phoneRegex.hasMatch(trimmed)) {
      return l10n.errorPhoneOrEmailField;
    }
    return null;
  }

  String? _validatePassword(String? value, S l10n) {
    if (value == null || value.isEmpty) {
      return l10n.errorFieldIsEmpty;
    }
    if (value.length < 8) {
      return l10n.errorConfirmPasswordField;
    }
    return null;
  }

  void _handleNext() {
    FocusScope.of(context).unfocus();
    if (_stepFormKey.currentState!.validate()) {
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final l10n = S.of(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Form(
        key: _stepFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              l10n.signupTitle1,
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 38),

            // Email / Phone
            AppTextField(
              controller: widget.phoneOrEmailController,
              label: l10n.email,
              hint: l10n.yourEmail,
              isRequired: true,
              enabled: !widget.isLoading,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) => _validatePhoneOrEmail(value, l10n),
              prefixIcon: Icon(Icons.mail_outline_rounded, color: colors.outline),
            ),
            const SizedBox(height: 24),

            // Password
            AppTextField(
              controller: widget.passwordController,
              label: l10n.passwordField,
              hint: l10n.createSecurePassword,
              isPassword: true,
              isRequired: true,
              enabled: !widget.isLoading,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _handleNext(),
              validator: (value) => _validatePassword(value, l10n),
              prefixIcon: Icon(Icons.lock_outline_rounded, color: colors.outline),
            ),
            const SizedBox(height: 24),
            PasswordStrengthBar(controller: widget.passwordController),

            // Signup Button
            const SizedBox(height: 32),
            AppButton.primary(text: l10n.next, trailingIcon: const Icon(Icons.arrow_forward_rounded), onPressed: _handleNext, height: 50),

            // Login Link
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(l10n.haveLoginAccount, style: textTheme.bodyMedium),
                const SizedBox(width: 4),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  onPressed: () => context.pop(),
                  child: Text(
                    l10n.login,
                    style: textTheme.bodyMedium?.copyWith(color: colors.primary, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
