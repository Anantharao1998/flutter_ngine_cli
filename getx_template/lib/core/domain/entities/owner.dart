import 'package:equatable/equatable.dart';

class Owner extends Equatable {
  final String? login;
  final String? avatarUrl;

  const Owner({required this.login, required this.avatarUrl});

  @override
  List<Object?> get props => [login, avatarUrl];
}
