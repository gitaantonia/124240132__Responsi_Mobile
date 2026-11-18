import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';
import '../screens/login.dart';
import '../screens/main_navigation.dart';

class AuthController extends GetxController {
  final RxBool isLoggedIn = false.obs;
  final RxString userEmail = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> checkLoginStatus() async {
    isLoggedIn.value = await AuthService.isLoggedIn();
    if (isLoggedIn.value) {
      final email = await AuthService.getLoggedInEmail();
      userEmail.value = email ?? '';
    }
  }

  Future<bool> login(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      Get.snackbar(
        'Validasi Gagal',
        'Email dan password tidak boleh kosong!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    isLoading.value = true;
    final success = await AuthService.login(email, password);
    isLoading.value = false;

    if (success) {
      isLoggedIn.value = true;
      userEmail.value = email.trim();

      await NotificationService.showNotification(
        id: 101,
        title: 'Login Berhasil',
        body: 'Selamat datang kembali di Hydra Games, ${email.trim()}!',
      );

      Get.offAll(() => const MainNavigation());
      return true;
    } else {
      Get.snackbar(
        'Login Gagal',
        'Email atau password salah!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<void> logout() async {
    await AuthService.logout();
    isLoggedIn.value = false;
    userEmail.value = '';

    await NotificationService.showNotification(
      id: 102,
      title: 'Logout',
      body: 'Anda telah berhasil logout dari Hydra Games.',
    );

    Get.offAll(() => const LoginScreen());
  }
}
