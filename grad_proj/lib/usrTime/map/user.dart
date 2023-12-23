import 'location.dart';

class User {
  final String? firstname;
  final String? lastname;

  final String? email;
  final String? UserName;
  final bool? city;
  final Location? location;

  User(
    this.firstname,
    this.lastname,
    this.email,
    this.UserName,
    this.city,
    this.location,
  );

  factory User.fromJson(Map<String, dynamic> json) => User(
        json['userFirstName'],
        json['userLastName'],
        json['email'],
        json['UserName'],
        json['city'],
        json['location'] != null ? Location.fromJson(json['location']) : null,
      );
}
