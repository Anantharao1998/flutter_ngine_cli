import 'package:juno_provider_base_project/core/data/models/owner_model.dart';
import 'package:juno_provider_base_project/core/domain/domain.dart';

class ItemModel extends Item {
  const ItemModel(
      {required super.name,
      required super.owner,
      required super.stargazersCount,
      required super.forks,
      required super.watchers,
      required super.score,
      required super.description});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
        name: json['name'],
        owner:
            json['owner'] != null ? OwnerModel.fromJson(json['owner']) : null,
        stargazersCount: json['stargazers_count'],
        forks: json['forks'],
        watchers: json['watchers'],
        score: json['score'],
        description: json['description']);
  }
}
