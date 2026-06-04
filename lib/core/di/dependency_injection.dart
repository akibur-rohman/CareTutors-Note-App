import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/data/repository/firebase_auth_repository.dart';
import '../../features/notes/domain/repository/notes_repository.dart';
import '../../features/notes/data/repository/firestore_notes_repository.dart';

import '../../features/onboarding/presentation/controllers/onboarding_controller.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/notes/presentation/controllers/notes_controller.dart';

class DependencyInjection {
  DependencyInjection._();

  static Future<void> init() async {
    // 1. Core Services
    final prefs = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(prefs, permanent: true);

    // 2. Repositories (Data Sources / Interfaces)
    Get.lazyPut<AuthRepository>(() => FirebaseAuthRepository(), fenix: true);
    Get.lazyPut<NotesRepository>(() => FirestoreNotesRepository(), fenix: true);

    // 3. Controllers
    Get.lazyPut(() => OnboardingController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => NotesController(), fenix: true);

    // Eagerly inject AuthController to start listening to the firebase auth changes immediately
    Get.find<AuthController>();
    // Eagerly inject OnboardingController to load onboarding state
    Get.find<OnboardingController>();
  }
}
