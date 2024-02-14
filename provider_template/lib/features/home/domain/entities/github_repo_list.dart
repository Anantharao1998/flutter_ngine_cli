import 'package:equatable/equatable.dart';
import 'package:juno_provider_base_project/core/domain/domain.dart';

class GithubRepoList extends Equatable {
  final int? totalCount;
  final bool? incompleteResults;
  final List<Item>? items;

  const GithubRepoList(
      {required this.totalCount,
      required this.incompleteResults,
      required this.items});

  @override
  List<Object?> get props => [totalCount, incompleteResults, items];
}
