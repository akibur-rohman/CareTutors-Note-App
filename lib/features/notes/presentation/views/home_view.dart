import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import 'package:notes/features/notes/presentation/widgets/brutalist_container.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../controllers/notes_controller.dart';

class HomeView extends GetView<NotesController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text(
          'THOUGHTS',
          style: AppTypography.headlineLgMobile.copyWith(color: AppColors.onSurface),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppColors.onSurface),
            tooltip: 'Sign Out',
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppColors.surfaceContainer,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: AppColors.black, width: AppSpacing.borderThicknessMedium),
                  ),
                  title: Text(
                    'SIGN OUT',
                    style: AppTypography.labelMd.copyWith(color: AppColors.onSurface),
                  ),
                  content: Text(
                    'ARE YOU SURE YOU WANT TO SIGN OUT?',
                    style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.onSurface,
                        backgroundColor: Colors.transparent,
                        side: BorderSide.none,
                      ),
                      child: Text(
                        'CANCEL',
                        style: AppTypography.labelSm,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        authController.logout();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.black,
                        backgroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.black, width: AppSpacing.borderThicknessMedium),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        'SIGN OUT',
                        style: AppTypography.labelSm.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3.0),
          child: Container(
            color: AppColors.black,
            height: AppSpacing.borderThicknessThick,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.notes.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.marginMobile),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'YOUR CANVAS IS EMPTY.',
                      style: AppTypography.labelMd.copyWith(color: AppColors.onSurface),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'TAP THE ACTION BUTTON BELOW TO RECORD YOUR FIRST THOUGHT.',
                      textAlign: CenterAlign.textAlign(TextAlign.center),
                      style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.marginMobile,
              vertical: AppSpacing.sm,
            ),
            itemCount: controller.notes.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final note = controller.notes[index];
              return Dismissible(
                key: Key(note.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  color: AppColors.errorContainer,
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.onErrorContainer,
                  ),
                ),
                onDismissed: (direction) {
                  controller.deleteNote(note.id);
                  Get.snackbar(
                    'DELETED',
                    'Note removed successfully.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.black,
                    colorText: AppColors.white,
                    margin: const EdgeInsets.all(16.0),
                    borderRadius: 0.0,
                    borderColor: AppColors.white,
                    borderWidth: 1.0,
                  );
                },
                child: BrutalistContainer(
                  width: double.infinity,
                  backgroundColor: AppColors.paleCream,
                  onTap: () {
                    context.push('/add-note', extra: note);
                  },
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              note.title.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.labelMd.copyWith(color: AppColors.black),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            _formatDate(note.createdAt),
                            style: AppTypography.caption.copyWith(color: AppColors.grey),
                          ),
                        ],
                      ),
                      if (note.description.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          note.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.black,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          right: AppSpacing.base,
          bottom: AppSpacing.base,
        ),
        child: BrutalistContainer(
          width: 60.0,
          height: 60.0,
          backgroundColor: AppColors.vibrantOrange,
          onTap: () => context.push('/add-note'),
          child: const Center(
            child: Icon(
              Icons.add_rounded,
              size: 32.0,
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'NOW';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}M AGO';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}H AGO';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}D AGO';
    } else {
      return '${date.day}/${date.month}/${date.year % 100}';
    }
  }
}

class CenterAlign {
  static TextAlign textAlign(TextAlign val) => val;
}
