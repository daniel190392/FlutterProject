import 'dart:convert';
import '../../resources/resources.dart';

class UserModel extends Equatable {
  final String userId;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String? avatarImage;

  const UserModel({
    required this.userId,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    this.avatarImage,
  });

  UserModel copyWith({
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    String? avatarImage,
  }) =>
      UserModel(
        userId: userId,
        name: name ?? this.name,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        avatarImage: avatarImage ?? this.avatarImage,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': userId,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'photo': avatarImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    try {
      return UserModel(
        userId: map['id'] as String,
        name: map['name'] as String,
        address: map['address'] as String,
        latitude: (map['latitude'] is! double) ? 0 : map['latitude'],
        longitude: (map['longitude'] is! double) ? 0 : map['longitude'],
        avatarImage: map['photo'] as String?,
      );
    } catch (exception) {
      throw const FormatException('Invalid JSON');
    }
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [name, address, latitude, longitude, avatarImage];
}
