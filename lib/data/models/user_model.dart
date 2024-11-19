// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? status;
  User? user;
  Authorisation? authorisation;

  UserModel({
    this.status,
    this.user,
    this.authorisation,
  });

  UserModel copyWith({
    String? status,
    User? user,
    Authorisation? authorisation,
  }) =>
      UserModel(
        status: status ?? this.status,
        user: user ?? this.user,
        authorisation: authorisation ?? this.authorisation,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    authorisation: json["authorisation"] == null ? null : Authorisation.fromJson(json["authorisation"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "user": user?.toJson(),
    "authorisation": authorisation?.toJson(),
  };
}

class Authorisation {
  String? token;
  String? type;

  Authorisation({
    this.token,
    this.type,
  });

  Authorisation copyWith({
    String? token,
    String? type,
  }) =>
      Authorisation(
        token: token ?? this.token,
        type: type ?? this.type,
      );

  factory Authorisation.fromJson(Map<String, dynamic> json) => Authorisation(
    token: json["token"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "type": type,
  };
}

class User {
  int? id;
  String? name;
  String? email;
  String? address;
  dynamic emailVerifiedAt;
  bool? isAdmin;
  bool? isAlive;
  String? fcmToken;
  String? companionPhone;
  bool? gender;
  DateTime? birthday;
  dynamic certificate;
  dynamic specialist;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.address,
    this.emailVerifiedAt,
    this.isAdmin,
    this.isAlive,
    this.fcmToken,
    this.companionPhone,
    this.gender,
    this.birthday,
    this.certificate,
    this.specialist,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? address,
    dynamic emailVerifiedAt,
    bool? isAdmin,
    bool? isAlive,
    String? fcmToken,
    String? companionPhone,
    bool? gender,
    DateTime? birthday,
    dynamic certificate,
    dynamic specialist,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        address: address ?? this.address,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        isAdmin: isAdmin ?? this.isAdmin,
        isAlive: isAlive ?? this.isAlive,
        fcmToken: fcmToken ?? this.fcmToken,
        companionPhone: companionPhone ?? this.companionPhone,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        certificate: certificate ?? this.certificate,
        specialist: specialist ?? this.specialist,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    address: json["address"],
    emailVerifiedAt: json["email_verified_at"],
    isAdmin: json["is_admin"],
    isAlive: json["is_alive"],
    fcmToken: json["fcm_token"],
    companionPhone: json["Companion_phone"],
    gender: json["gender"],
    birthday: json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
    certificate: json["certificate"],
    specialist: json["specialist"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "address": address,
    "email_verified_at": emailVerifiedAt,
    "is_admin": isAdmin,
    "is_alive": isAlive,
    "fcm_token": fcmToken,
    "Companion_phone": companionPhone,
    "gender": gender,
    "birthday": "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
    "certificate": certificate,
    "specialist": specialist,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
