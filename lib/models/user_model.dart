import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String profileImageUrl;
  final String profileUrl;
  const User({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    required this.profileUrl,
  });

  @override
  List<Object> get props => [id, name, profileImageUrl, profileUrl];

  // @override
  bool get stringfy => true;

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      profileImageUrl: map['profile_image']['small'],
      profileUrl: map['links']['html'],
    );
  }
}
