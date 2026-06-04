import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  static const String _key = 'has_seen_onboarding';

  final _hasSeenOnboarding = false.obs;
  bool get hasSeenOnboarding => _hasSeenOnboarding.value;

  @override
  void onInit() {
    super.onInit();
    _loadState();
  }

  void _loadState() {
    _hasSeenOnboarding.value = _prefs.getBool(_key) ?? false;
  }

  Future<void> completeOnboarding() async {
    await _prefs.setBool(_key, true);
    _hasSeenOnboarding.value = true;
  }
}
