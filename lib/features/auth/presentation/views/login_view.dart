import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import 'package:notes/features/notes/presentation/widgets/brutalist_container.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await _authController.login(
        _emailController.text,
        _passwordController.text,
      );
      if (success && mounted) {
        context.go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.marginMobile,
              vertical: AppSpacing.md,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Title / Subtitle
                  Text(
                    'WELCOME BACK',
                    style: AppTypography.headlineLg.copyWith(color: AppColors.onSurface),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'SIGN IN TO ACCESS YOUR THOUGHTS.',
                    style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Email Input Field
                  Text(
                    'EMAIL ADDRESS',
                    style: AppTypography.labelMd.copyWith(color: AppColors.onSurface),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: AppTypography.bodyMd.copyWith(color: AppColors.black),
                    decoration: const InputDecoration(
                      hintText: 'name@example.com',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Password Input Field
                  Text(
                    'PASSWORD',
                    style: AppTypography.labelMd.copyWith(color: AppColors.onSurface),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: AppTypography.bodyMd.copyWith(color: AppColors.black),
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Submit Button
                  Obx(() {
                    final isLoading = _authController.isLoading.value;
                    return BrutalistContainer(
                      width: double.infinity,
                      height: 56.0,
                      backgroundColor: AppColors.vibrantOrange,
                      onTap: isLoading ? null : _submit,
                      child: Center(
                        child: isLoading
                            ? const SizedBox(
                                width: 24.0,
                                height: 24.0,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  color: AppColors.black,
                                ),
                              )
                            : Text(
                                'SIGN IN',
                                style: AppTypography.labelMd.copyWith(color: AppColors.black),
                              ),
                      ),
                    );
                  }),
                  const SizedBox(height: AppSpacing.md),

                  // Secondary Navigation Link (Ghost button style)
                  BrutalistContainer(
                    width: double.infinity,
                    height: 56.0,
                    backgroundColor: AppColors.paleCream,
                    onTap: () {
                      context.push('/register');
                    },
                    child: Center(
                      child: Text(
                        'REGISTER AN ACCOUNT',
                        style: AppTypography.labelMd.copyWith(color: AppColors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
