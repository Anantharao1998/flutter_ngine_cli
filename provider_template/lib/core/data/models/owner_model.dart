import 'package:juno_provider_base_project/core/domain/domain.dart';

class OwnerModel extends Owner {
  const OwnerModel({required super.login, required super.avatarUrl});

  factory OwnerModel.fromJson(dynamic json) {
    return OwnerModel(login: json['login'], avatarUrl: json['avatar_url']);
  }
}
