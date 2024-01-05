import 'dart:convert';

class CalculationResponseModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  CalculationResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory CalculationResponseModel.fromRawJson(String str) => CalculationResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CalculationResponseModel.fromJson(Map<String, dynamic> json) => CalculationResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? type;
  Attributes? attributes;

  Data({
    this.type,
    this.attributes,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "attributes": attributes?.toJson(),
  };
}

class Attributes {
  String? checkInTime;
  String? checkOutTime;
  double? totalHours;
  int? totalDays;
  int? totalAmount;

  Attributes({
    this.checkInTime,
    this.checkOutTime,
    this.totalHours,
    this.totalDays,
    this.totalAmount,
  });

  factory Attributes.fromRawJson(String str) => Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    checkInTime: json["checkInTime"],
    checkOutTime: json["checkOutTime"],
    totalHours: json["totalHours"]?.toDouble(),
    totalDays: json["totalDays"],
    totalAmount: json["totalAmount"],
  );

  Map<String, dynamic> toJson() => {
    "checkInTime": checkInTime,
    "checkOutTime": checkOutTime,
    "totalHours": totalHours,
    "totalDays": totalDays,
    "totalAmount": totalAmount,
  };
}
