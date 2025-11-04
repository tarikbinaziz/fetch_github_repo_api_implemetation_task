import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:github_repos_app/routes.dart';
import '../controllers/auth_controller.dart';
import '../controllers/repos_controller.dart';
import '../widgets/repo_list_tile.dart';
import '../widgets/repo_grid_tile.dart';
import 'repo_detail_page.dart';
import 'package:intl/intl.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});
  final auth = Get.find<AuthController>();
  final reposCtrl = Get.find<ReposController>();

  final TextEditingController searchCtrl = TextEditingController();

  void _openSortMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(title: const Text('Sort by name'), onTap: () { reposCtrl.changeSort(SortBy.name); Navigator.pop(ctx); }),
              ListTile(title: const Text('Sort by created date'), onTap: () { reposCtrl.changeSort(SortBy.created); Navigator.pop(ctx); }),
              ListTile(title: const Text('Sort by updated date'), onTap: () { reposCtrl.changeSort(SortBy.updated); Navigator.pop(ctx); }),
              ListTile(title: const Text('Sort by stars'), onTap: () { reposCtrl.changeSort(SortBy.stars); Navigator.pop(ctx); }),
              ListTile(title: const Text('Sort by forks'), onTap: () { reposCtrl.changeSort(SortBy.forks); Navigator.pop(ctx); }),
              SwitchListTile(
                title: const Text('Ascending'),
                value: reposCtrl.ascending.value,
                onChanged: (v) {
                  reposCtrl.ascending.value = v;
                  reposCtrl.applyFilterAndSort(query: searchCtrl.text);
                },
              ),
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final authUser = auth.user.value;
    return Scaffold(
      appBar: AppBar(
        title: Text(authUser?.login ?? 'Repos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _openSortMenu(context),
            tooltip: 'Sort / Filter',
          ),
          Obx(() => IconButton(
            icon: Icon(reposCtrl.viewMode.value == ViewMode.list ? Icons.grid_view : Icons.list),
            onPressed: () => reposCtrl.toggleView(),
          )),
          // Theme toggle
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              final box = GetStorage();
              final isDark = Get.isDarkMode;
              box.write('isDark', !isDark);
              Get.changeThemeMode(!isDark ? ThemeMode.dark : ThemeMode.light);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchCtrl,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search repos by name, desc, language',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => reposCtrl.applyFilterAndSort(query: v),
            ),
          ),
          Expanded(child: Obx(() {
            if (reposCtrl.loading.value) return const Center(child: CircularProgressIndicator());
            if (reposCtrl.error.value != null) return Center(child: Text(reposCtrl.error.value!));
            if (reposCtrl.filtered.isEmpty) return const Center(child: Text('No repos found'));

            if (reposCtrl.viewMode.value == ViewMode.list) {
              return ListView.separated(
                itemCount: reposCtrl.filtered.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (ctx, idx) {
                  final r = reposCtrl.filtered[idx];
                  return RepoListTile(repo: r, onTap: () {
                    Get.toNamed(Routes.detail, arguments: r);
                  });
                },
              );
            } else {
              // grid
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.3),
                itemCount: reposCtrl.filtered.length,
                itemBuilder: (ctx, idx) {
                  final r = reposCtrl.filtered[idx];
                  return RepoGridTile(repo: r, onTap: () {
                    Get.toNamed(Routes.detail, arguments: r);
                  });
                },
              );
            }
          })),
        ],
      ),
    );
  }
}
