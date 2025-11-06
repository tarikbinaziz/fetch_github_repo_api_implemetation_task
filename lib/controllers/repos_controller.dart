import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/repo_model.dart';
import '../services/api_service.dart';

enum ViewMode { list, grid }
enum SortBy { name, created, updated, stars, forks }

class ReposController extends GetxController {
  final ApiService api = Get.find();
  final box = GetStorage();

  var repos = <RepoModel>[].obs;
  var filtered = <RepoModel>[].obs;
  var loading = false.obs;
  var error = Rxn<String>();
  var viewMode = ViewMode.list.obs;
  var sortBy = SortBy.name.obs;
  var ascending = false.obs; // descending by default for dates/stars

  String get lastUsername => box.read('last_username') ?? '';

  @override
  void onInit() {
    super.onInit();
    final saved = box.read('viewMode');
    if (saved != null) viewMode.value = saved == 'grid' ? ViewMode.grid : ViewMode.list;
  }

  Future<void> loadRepos(String username) async {
    loading.value = true;
    error.value = null;
    try {
      final list = await api.fetchRepos(username);
      repos.assignAll(list);
      applyFilterAndSort();
      loading.value = false;
      box.write('last_username', username);
    } catch (e) {
      loading.value = false;
      error.value = e.toString();
    }
  }

  void applyFilterAndSort({String? query}) {
    List<RepoModel> list = List.from(repos);
    if (query != null && query.trim().isNotEmpty) {
      final q = query.toLowerCase();
      list = list.where((r) =>
        r.name.toLowerCase().contains(q) ||
        r.description.toLowerCase().contains(q) ||
        r.language.toLowerCase().contains(q)
      ).toList();
    }

    // sort
    list.sort((a, b) {
      int cmp = 0;
      switch (sortBy.value) {
        case SortBy.name:
          cmp = a.name.toLowerCase().compareTo(b.name.toLowerCase());
          break;
        case SortBy.created:
          cmp = a.createdAt.compareTo(b.createdAt);
          break;
        case SortBy.updated:
          cmp = a.updatedAt.compareTo(b.updatedAt);
          break;
        case SortBy.stars:
          cmp = a.stargazersCount.compareTo(b.stargazersCount);
          break;
        case SortBy.forks:
          cmp = a.forksCount.compareTo(b.forksCount);
          break;
      }
      return ascending.value ? cmp : -cmp;
    });

    filtered.assignAll(list);
  }

  void toggleView() {
    viewMode.value = viewMode.value == ViewMode.list ? ViewMode.grid : ViewMode.list;
    box.write('viewMode', viewMode.value == ViewMode.grid ? 'grid' : 'list');
  }

  void changeSort(SortBy s, {bool? asc}) {
    sortBy.value = s;
    if (asc != null) ascending.value = asc;
    applyFilterAndSort();
  }
}