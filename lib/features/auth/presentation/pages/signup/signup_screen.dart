import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:workbridge/core/constants/api_constants.dart';
import 'package:workbridge/core/errors/exceptions.dart';
import 'package:workbridge/core/network/dio_client.dart';
import 'package:workbridge/core/routing/app_router.dart';
import 'package:workbridge/core/utils/app_assets.dart';
import 'package:workbridge/core/utils/secure_storage_service.dart';
import 'package:workbridge/core/widgets/custom_error_widget.dart';
import 'package:workbridge/features/auth/presentation/pages/signup/steps/choose_path.dart';
import 'package:workbridge/features/auth/presentation/pages/signup/steps/email_password_step.dart';
import 'package:workbridge/features/auth/presentation/pages/signup/steps/name_step.dart';
import 'package:workbridge/features/auth/presentation/pages/signup/widgets/signup_step_counter.dart';
import 'package:workbridge/generated/l10n.dart';
import 'package:workbridge/injection_container.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _pageController = PageController();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneOrEmailController;
  late final TextEditingController _passwordController;

  int _currentStep = 0;
  UserPath? _selectedPath = UserPath.work;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneOrEmailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneOrEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    if (step < 0 || step > 2) return;
    FocusScope.of(context).unfocus();
    _pageController.animateToPage(step, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _nextStep() {
    if (_currentStep == 0) {
      if (_selectedPath != null) {
        _goToStep(1);
      }
    } else if (_currentStep == 1) {
      if (_phoneOrEmailController.text.trim().isNotEmpty && _passwordController.text.isNotEmpty) {
        _goToStep(2);
      }
    } else if (_currentStep == 2) {
      _handleSignup();
    }
  }

  Future<void> _handleSignup() async {
    FocusScope.of(context).unfocus();

    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _phoneOrEmailController.text.trim();
    final password = _passwordController.text;

    // Guard: Ensure step 1 details are present
    if (firstName.isEmpty || lastName.isEmpty) {
      _goToStep(1);
      return;
    }

    if (email.isEmpty || password.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final role = _getRoleString(_selectedPath ?? UserPath.work);

      final dioClient = sl<DioClient>();
      final secureStorage = sl<SecureStorageService>();

      final response = await dioClient.post(ApiConstants.register, data: {'firstName': firstName, 'lastName': lastName, 'email': email, 'password': password, 'role': role});

      final data = response.data as Map<String, dynamic>;
      final accessToken = data['accessToken'] as String?;
      final userRole = data['role'] as String? ?? role;

      if (accessToken != null) {
        await secureStorage.saveToken(accessToken);
      }
      await secureStorage.saveUserRole(userRole);

      if (!mounted) return;

      context.go(AppRoutes.home);
    } on ServerException catch (e) {
      if (!mounted) return;
      _showErrorDialog(e.message ?? S.of(context).serverError);
    } catch (e) {
      if (!mounted) return;
      _showErrorDialog(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorDialog(String errorMessage) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomErrorWidget(
          title: S.of(context).error,
          message: errorMessage,
          onRetry: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  String _getRoleString(UserPath userPath) {
    switch (userPath) {
      case UserPath.work:
        return 'job_seeker';
      case UserPath.hire:
        return 'employer';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = S.of(context);

    return PopScope(
      canPop: _currentStep == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _currentStep > 0) {
          _goToStep(_currentStep - 1);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SignupStepCounter(step: _currentStep),
                const SizedBox(height: 28),
                Image.asset(AppAssets.appIconTextNoBG, height: 120, width: 120, fit: BoxFit.contain, semanticLabel: l10n.appName),
                const SizedBox(height: 8),
                Expanded(
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _currentStep = index;
                      });
                    },
                    children: [
                      ChoosePathStep(
                        selectedPath: _selectedPath,
                        onPathSelected: (path) {
                          setState(() {
                            _selectedPath = path;
                          });
                        },
                        onNext: _nextStep,
                      ),
                      EmailPasswordStep(phoneOrEmailController: _phoneOrEmailController, passwordController: _passwordController, onNext: _nextStep, isLoading: _isLoading),
                      NameStep(firstNameController: _firstNameController, lastNameController: _lastNameController, onSubmit: _handleSignup, isLoading: _isLoading),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text("${l10n.signupScreenFooterTerms} ", style: textTheme.bodySmall),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          l10n.termsOfService,
                          style: textTheme.bodySmall?.copyWith(decoration: TextDecoration.underline, fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(" & ", style: textTheme.bodySmall),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          l10n.privacyPolicy,
                          style: textTheme.bodySmall?.copyWith(decoration: TextDecoration.underline, fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                      ),
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
