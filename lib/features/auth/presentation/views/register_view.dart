import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import 'package:notes/features/notes/presentation/widgets/brutalist_container.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await _authController.register(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
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
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: AppColors.black,
            height: AppSpacing.borderThicknessMedium,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.marginMobile,
            vertical: AppSpacing.md,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CREATE ACCOUNT',
                  style: AppTypography.headlineLgMobile.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'JOIN US TO RECORD AND ORGANIZE DAILY LOGS.',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Name Field
                Text(
                  'FULL NAME',
                  style: AppTypography.labelMd.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  style: AppTypography.bodyMd.copyWith(color: AppColors.black),
                  decoration: const InputDecoration(hintText: 'John Doe'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.sm),

                // Email Field
                Text(
                  'EMAIL ADDRESS',
                  style: AppTypography.labelMd.copyWith(
                    color: AppColors.onSurface,
                  ),
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

                // Password Field
                Text(
                  'PASSWORD',
                  style: AppTypography.labelMd.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: AppTypography.bodyMd.copyWith(color: AppColors.black),
                  decoration: const InputDecoration(
                    hintText: 'At least 6 characters',
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
                const SizedBox(height: AppSpacing.sm),

                // Confirm Password Field
                Text(
                  'CONFIRM PASSWORD',
                  style: AppTypography.labelMd.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  style: AppTypography.bodyMd.copyWith(color: AppColors.black),
                  decoration: const InputDecoration(
                    hintText: 'Re-enter your password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
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
                              'CREATE ACCOUNT',
                              style: AppTypography.labelMd.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                    ),
                  );
                }),
                const SizedBox(height: AppSpacing.sm),

                // Cancel Link (Ghost text button)
                Center(
                  child: TextButton(
                    onPressed: () => context.pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.onSurface,
                      backgroundColor: Colors.transparent,
                      side: BorderSide.none,
                    ),
                    child: Text(
                      'BACK TO SIGN IN',
                      style: AppTypography.labelSm.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
