// ignore_for_file: override_on_non_overriding_member

import 'package:equatable/equatable.dart';

import 'user_model.dart';

class Photo extends Equatable {
  final String id;
  final String url;
  final String description;
  final User user;
  const Photo({
    required this.id,
    required this.url,
    required this.description,
    required this.user,
  });

  @override
  List<Object> get props => [id, url, description, user];

  @override
  bool get stringfy => true;

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'],
      url: map['urls']['regular'],
      description: map['description'] ?? 'No description',
      user: User.fromMap(map['user']),
    );
  }
}
