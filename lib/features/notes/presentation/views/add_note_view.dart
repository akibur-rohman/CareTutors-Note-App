import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import 'package:notes/features/notes/presentation/widgets/brutalist_container.dart';
import '../../domain/model/note_model.dart';
import '../controllers/notes_controller.dart';

class AddNoteView extends StatefulWidget {
  final NoteModel? initialNote;

  const AddNoteView({super.key, this.initialNote});

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _notesController = Get.find<NotesController>();

  bool get _isEditing => widget.initialNote != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _titleController.text = widget.initialNote!.title;
      _descriptionController.text = widget.initialNote!.description;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty) {
      Get.snackbar(
        'REQUIRED',
        'Please enter a title for your note.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.black,
        colorText: AppColors.white,
        margin: const EdgeInsets.all(16.0),
        borderRadius: 0.0,
        borderColor: AppColors.white,
        borderWidth: 1.0,
      );
      return;
    }

    bool success;
    if (_isEditing) {
      success = await _notesController.updateNote(
        widget.initialNote!.id,
        title,
        description,
      );
    } else {
      success = await _notesController.addNote(title, description);
    }

    if (success && mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
          onPressed: () => context.pop(),
        ),
        actions: [
          Obx(() {
            final isLoading = _notesController.isLoading.value;
            return Padding(
              padding: const EdgeInsets.only(
                right: AppSpacing.sm,
                top: AppSpacing.xs,
                bottom: AppSpacing.xs,
              ),
              child: BrutalistContainer(
                backgroundColor: AppColors.vibrantOrange,
                onTap: isLoading ? null : _save,
                offsetDistance: 2.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                child: Center(
                  child: isLoading
                      ? const SizedBox(
                          width: 16.0,
                          height: 16.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: AppColors.black,
                          ),
                        )
                      : Text(
                          'SAVE',
                          style: AppTypography.labelMd.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            );
          }),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.marginMobile),
          child: Column(
            children: [
              // Borderless Title Input
              TextField(
                controller: _titleController,
                style: AppTypography.headlineLgMobile.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'TITLE',
                  hintStyle: AppTypography.headlineLgMobile.copyWith(
                    color: AppColors.surfaceBright,
                    fontWeight: FontWeight.w700,
                  ),
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Container(
                height: AppSpacing.borderThicknessMedium,
                color: AppColors.black,
              ),
              const SizedBox(height: AppSpacing.sm),
              // Borderless Body Input
              Expanded(
                child: TextField(
                  controller: _descriptionController,
                  style: AppTypography.bodyLg.copyWith(
                    color: AppColors.onSurface,
                    height: 1.6,
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'START WRITING YOUR THOUGHTS...',
                    hintStyle: AppTypography.bodyLg.copyWith(
                      color: AppColors.grey.withValues(alpha: 0.5),
                    ),
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
