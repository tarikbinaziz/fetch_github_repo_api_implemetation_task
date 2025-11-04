import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/repo_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class RepoDetailPage extends StatelessWidget {
  RepoDetailPage({super.key});
  final RepoModel repo = Get.arguments as RepoModel;

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat.yMMMd();
    return Scaffold(
      appBar: AppBar(title: Text(repo.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(repo.fullName, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            if (repo.description.isNotEmpty) Text(repo.description),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text('⭐ ${repo.stargazersCount}')),
                Chip(label: Text('🍴 ${repo.forksCount}')),
                if (repo.language.isNotEmpty) Chip(label: Text(repo.language)),
              ],
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text('Created: ${fmt.format(repo.createdAt)}'),
            ),
            ListTile(
              leading: const Icon(Icons.update),
              title: Text('Updated: ${fmt.format(repo.updatedAt)}'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open on GitHub'),
              onPressed: () async {
                final uri = Uri.parse(repo.htmlUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  Get.snackbar('Error', 'Could not open URL');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
