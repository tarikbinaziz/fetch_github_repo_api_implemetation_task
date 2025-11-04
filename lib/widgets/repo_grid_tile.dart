import 'package:flutter/material.dart';
import '../models/repo_model.dart';

class RepoGridTile extends StatelessWidget {
  final RepoModel repo;
  final VoidCallback onTap;
  const RepoGridTile({super.key, required this.repo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(6),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(repo.name, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 6),
              Expanded(child: Text(repo.description.isEmpty ? 'No description' : repo.description, maxLines: 4, overflow: TextOverflow.ellipsis)),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(repo.language),
                  Text('⭐ ${repo.stargazersCount}'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
