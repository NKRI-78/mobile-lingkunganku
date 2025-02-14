import 'package:equatable/equatable.dart';
import '../../../repositories/profile_repository/models/profile_model.dart';

class FamiliesModel extends Equatable {
  final int id;
  final String username;
  final String email;
  final String phone;
  final ProfileModel? profile;

  const FamiliesModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    this.profile,
  });

  factory FamiliesModel.fromJson(Map<String, dynamic> json) {
    return FamiliesModel(
      id: json["id"],
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      profile: json["profile"] != null
          ? ProfileModel.fromJson(json["profile"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "phone": phone,
      "profile": profile?.toJson(),
    };
  }

  @override
  List<Object?> get props => [id, username, email, phone, profile];
}
