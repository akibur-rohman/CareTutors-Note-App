import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import 'package:notes/features/notes/presentation/widgets/brutalist_container.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.marginMobile,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              // Neo-Brutalist Top Border / Accent Line
              Container(
                width: 64.0,
                height: AppSpacing.borderThicknessThick,
                color: AppColors.vibrantOrange,
              ),
              const SizedBox(height: AppSpacing.md),
              // Space Grotesk Display Title
              Text(
                'CARETUTORS\nNOTE',
                style: AppTypography.displayLg.copyWith(
                  color: AppColors.onSurface,
                  height: 1.0,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              Text(
                'A smart note-taking app for students. Organize class notes, assignments, study materials, and important ideas in one secure place.',
                style: AppTypography.bodyLg.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const Spacer(flex: 3),
              // Brutalist Action Button
              BrutalistContainer(
                width: double.infinity,
                height: 56.0,
                backgroundColor: AppColors.vibrantOrange,
                onTap: () async {
                  await controller.completeOnboarding();
                  if (context.mounted) {
                    context.go('/login');
                  }
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'GET STARTED',
                        style: AppTypography.labelMd.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 18.0,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
