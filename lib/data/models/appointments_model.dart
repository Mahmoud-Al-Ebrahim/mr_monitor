// To parse this JSON data, do
//
//     final appointmentModel = appointmentModelFromJson(jsonString);

import 'dart:convert';

List<AppointmentModel> appointmentModelFromJson(String str) => List<AppointmentModel>.from(json.decode(str).map((x) => AppointmentModel.fromJson(x)));

String appointmentModelToJson(List<AppointmentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppointmentModel {
  final int? id;
  final int? dosesNum;
  final int? taken;
  final String? name;
  final String? time;
  final String? time2;
  final dynamic time3;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AppointmentModel({
    this.id,
    this.dosesNum,
    this.taken,
    this.name,
    this.time,
    this.time2,
    this.time3,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  AppointmentModel copyWith({
    int? id,
    int? dosesNum,
    int? taken,
    String? name,
    String? time,
    String? time2,
    dynamic time3,
    int? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      AppointmentModel(
        id: id ?? this.id,
        dosesNum: dosesNum ?? this.dosesNum,
        taken: taken ?? this.taken,
        name: name ?? this.name,
        time: time ?? this.time,
        time2: time2 ?? this.time2,
        time3: time3 ?? this.time3,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory AppointmentModel.fromJson(Map<String, dynamic> json) => AppointmentModel(
    id: json["id"],
    dosesNum: json["doses_num"],
    taken: json["taken"],
    name: json["name"],
    time: json["time"],
    time2: json["time2"],
    time3: json["time3"],
    userId: json["user_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "doses_num": dosesNum,
    "taken": taken,
    "name": name,
    "time": time,
    "time2": time2,
    "time3": time3,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
