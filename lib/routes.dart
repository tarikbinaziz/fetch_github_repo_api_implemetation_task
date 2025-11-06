import 'package:get/get.dart';
import 'package:github_repos_app/views/home_page.dart';
import 'package:github_repos_app/views/login_page.dart';
import 'package:github_repos_app/views/repo_detail_page.dart';

class Routes {
  static const login = '/';
  static const home = '/home';
  static const detail = '/detail';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.login, page: () => LoginPage()),
    GetPage(name: Routes.home, page: () => HomePage()),
    GetPage(name: Routes.detail, page: () => RepoDetailPage()),
  ];
}
