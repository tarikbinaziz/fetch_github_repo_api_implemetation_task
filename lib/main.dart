import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:github_repos_app/app_binding.dart';
import 'package:github_repos_app/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = GetStorage();
  MyApp({super.key});

  ThemeMode get initialTheme {
    final saved = box.read('isDark');
    if (saved == null) return ThemeMode.system;
    return saved == true ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GitHub Repos',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: initialTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: Routes.login,
      getPages: AppPages.pages,
    );
  }
}
