import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_repos_app/routes.dart';

import '../controllers/auth_controller.dart';
import '../controllers/repos_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final auth = Get.find<AuthController>();
  final repos = Get.find<ReposController>();
  final TextEditingController _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _ctrl.text = auth.box.read('last_username') ?? '';
    return Scaffold(
      appBar: AppBar(title: const Text('GitHub User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _ctrl,
              decoration: const InputDecoration(
                labelText: 'GitHub username',
                hintText: 'e.g. torvalds',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                final name = _ctrl.text.trim();
                if (name.isEmpty) {
                  Get.snackbar('Error', 'Please enter username');
                  return;
                }
                await auth.fetchUser(name);
                if (auth.error.value != null) {
                  Get.snackbar('Error', auth.error.value!);
                } else {
                  await repos.loadRepos(name);
                  Get.offNamed(Routes.home);
                }
              },
              child: const Text('Continue'),
            ),
            Obx(() {
              if (auth.loading.value)
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                );
              if (auth.user.value != null) {
                final u = auth.user.value!;
                return ListTile(
                  leading: Image.network(u.avatarUrl, width: 50, height: 50),
                  title: Text(u.name.isEmpty ? u.login : u.name),
                  subtitle: Text(
                    '${u.publicRepos} repos • ${u.followers} followers',
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
            Obx(() {
              if (auth.error.value != null) {
                return Text(
                  auth.error.value!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
