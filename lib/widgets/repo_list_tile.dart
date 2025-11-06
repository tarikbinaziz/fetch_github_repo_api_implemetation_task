import 'package:flutter/material.dart';
import '../models/repo_model.dart';

class RepoListTile extends StatelessWidget {
  final RepoModel repo;
  final VoidCallback onTap;
  const RepoListTile({super.key, required this.repo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(repo.name),
      subtitle: Text(repo.description.isEmpty ? 'No description' : repo.description, maxLines: 2, overflow: TextOverflow.ellipsis),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('⭐ ${repo.stargazersCount}'),
          Text('🍴 ${repo.forksCount}'),
        ],
      ),
    );
  }
}
