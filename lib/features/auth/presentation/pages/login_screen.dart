import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workbridge/core/utils/app_assets.dart';
import 'package:workbridge/core/widgets/app_button.dart';
import 'package:workbridge/core/widgets/app_text_field.dart';
import 'package:workbridge/features/home/presentation/pages/home_screen.dart';
import 'package:workbridge/generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _phoneOrEmailController;
  late final TextEditingController _passwordController;
  bool _isLoading = false;
  bool _rememberValue = false;

  @override
  void initState() {
    super.initState();
    _phoneOrEmailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneOrEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Replace with AuthBloc / AuthRepository login call
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
    if (value.length < 6) {
      return l10n.errorConfirmPasswordField;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final l10n = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 150.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Text("W", style: textTheme.displayLarge?.copyWith(color: colors.primary, fontWeight: FontWeight(900))),
                Text("bridge", style: textTheme.displaySmall),

                // Form Fields
                const SizedBox(height: 60),
                AppTextField(
                  controller: _phoneOrEmailController,
                  label: l10n.email,
                  hint: l10n.yourEmail,
                  isRequired: true,
                  enabled: !_isLoading,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) => _validatePhoneOrEmail(value, l10n),
                  prefixIcon: Icon(Icons.mail_outline_rounded, color: colors.outline),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _passwordController,
                  label: l10n.passwordField,
                  hint: l10n.passwordField,
                  isPassword: true,
                  isRequired: true,
                  enabled: !_isLoading,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleLogin(),
                  validator: (value) => _validatePassword(value, l10n),
                  prefixIcon: Icon(Icons.lock_outline_rounded, color: colors.outline),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(value: _rememberValue, activeColor: colors.primary, onChanged: (value) => setState(() => _rememberValue = value ?? false)),
                        Text(l10n.rememberCheckbox, style: textTheme.labelMedium),
                      ],
                    ),
                    TextButton(child: Text(l10n.forgotPassword), onPressed: () {}),
                  ],
                ),

                // Login Button
                const SizedBox(height: 32),
                AppButton.primary(text: l10n.login, trailingIcon: Icon(Icons.arrow_forward_rounded), isLoading: _isLoading, onPressed: _isLoading ? null : _handleLogin, height: 50),

                // ---------- Social Login Buttons ----------
                // const SizedBox(height: 24),
                // Row(
                //   children: [
                //     Expanded(child: Divider(color: colors.outline)),
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
                //       child: Text(l10n.continueLoginWithOptions, style: textTheme.bodySmall),
                //     ),
                //     Expanded(child: Divider(color: colors.outline)),
                //   ],
                // ),
                // const SizedBox(height: 16),
                // Row(
                //   children: [
                //     Expanded(
                //       child: AppButton.secondary(text: "Google", onPressed: () {}),
                //     ),
                //     const SizedBox(width: 12),
                //     Expanded(
                //       child: AppButton.primary(text: "Facebook", onPressed: () {}),
                //     ),
                //   ],
                // ),

                // Sign Up
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(l10n.haveNoLoginAccount, style: textTheme.bodyMedium),
                          const SizedBox(width: 4),
                          TextButton(
                            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                            onPressed: () => context.push("/signup"),
                            child: Text(
                              l10n.signup,
                              style: textTheme.bodyMedium?.copyWith(color: colors.primary, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),

                      // const SizedBox(height: 70),
                      // // Terms & Privacy Policy Footer
                      // Wrap(
                      //   alignment: WrapAlignment.center,
                      //   crossAxisAlignment: WrapCrossAlignment.center,
                      //   children: [
                      //     Text("${l10n.signupScreenFooterTerms} ", style: textTheme.bodySmall),
                      //     GestureDetector(
                      //       onTap: () {},
                      //       child: Text(
                      //         l10n.termsOfService,
                      //         style: textTheme.bodySmall?.copyWith(decoration: TextDecoration.underline, fontSize: 11, fontWeight: FontWeight.w600),
                      //       ),
                      //     ),
                      //     Text(" & ", style: textTheme.bodySmall),
                      //     GestureDetector(
                      //       onTap: () {},
                      //       child: Text(
                      //         l10n.privacyPolicy,
                      //         style: textTheme.bodySmall?.copyWith(decoration: TextDecoration.underline, fontSize: 11, fontWeight: FontWeight.w600),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
