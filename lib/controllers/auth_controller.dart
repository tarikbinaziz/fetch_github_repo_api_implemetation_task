import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../services/api_service.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final ApiService api = Get.find();
  final box = GetStorage();

  var username = ''.obs;
  var user = Rxn<UserModel>();
  var loading = false.obs;
  var error = Rxn<String>();

  Future<void> fetchUser(String name) async {
    loading.value = true;
    error.value = null;
    try {
      final u = await api.fetchUser(name);
      user.value = u;
      username.value = name;
      loading.value = false;
      // optional: store last username
      box.write('last_username', name);
    } catch (e) {
      loading.value = false;
      error.value = e.toString();
    }
  }
}
