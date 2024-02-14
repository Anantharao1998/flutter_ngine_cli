import 'package:equatable/equatable.dart';

import 'owner.dart';

class Item extends Equatable {
  final String? name;
  final Owner? owner;
  final int? stargazersCount;
  final int? forks;
  final int? watchers;
  final double? score;
  final String? description;

  const Item(
      {required this.name,
      required this.owner,
      required this.stargazersCount,
      required this.forks,
      required this.watchers,
      required this.score,
      required this.description});

  @override
  List<Object?> get props =>
      [name, owner, stargazersCount, forks, watchers, score, description];
}
