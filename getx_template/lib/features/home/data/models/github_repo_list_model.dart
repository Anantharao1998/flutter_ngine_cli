import 'package:juno_getx_base_project/core/data/models/item_model.dart';
import 'package:juno_getx_base_project/features/home/domain/entities/github_repo_list.dart';

class GithubRepoListModel extends GithubRepoList {
  const GithubRepoListModel(
      {required super.totalCount,
      required super.incompleteResults,
      required super.items});

  factory GithubRepoListModel.fromJson(Map<String, dynamic> json) {
    return GithubRepoListModel(
        totalCount: json['total_count'],
        incompleteResults: json['incomplete_results'],
        items: json['items'] != null
            ? List<ItemModel>.from(
                (json['items'] as List<dynamic>).map(
                  (e) => ItemModel.fromJson(e as Map<String, dynamic>),
                ),
              )
            : null);
  }
}
