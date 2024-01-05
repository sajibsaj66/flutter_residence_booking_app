// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  HomeModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
  List<Residence>? residences;
  Pagination? pagination;

  Attributes({
    this.residences,
    this.pagination,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    residences: json["residences"] == null ? [] : List<Residence>.from(json["residences"]!.map((x) => Residence.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "residences": residences == null ? [] : List<dynamic>.from(residences!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Pagination {
  int? totalDocuments;
  int? totalPage;
  int? currentPage;
  dynamic previousPage;
  dynamic nextPage;

  Pagination({
    this.totalDocuments,
    this.totalPage,
    this.currentPage,
    this.previousPage,
    this.nextPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalDocuments: json["totalDocuments"],
    totalPage: json["totalPage"],
    currentPage: json["currentPage"],
    previousPage: json["previousPage"],
    nextPage: json["nextPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalDocuments": totalDocuments,
    "totalPage": totalPage,
    "currentPage": currentPage,
    "previousPage": previousPage,
    "nextPage": nextPage,
  };
}

class Residence {
  String? id;
  String? residenceName;
  List<Photo>? photo;
  int? capacity;
  int? beds;
  int? baths;
  String? address;
  String? city;
  String? municipality;
  String? quirtier;
  String? aboutResidence;
  int? hourlyAmount;
  int? popularity;
  int? ratings;
  int? dailyAmount;
  List<Category>? amenities;
  String? ownerName;
  String? hostId;
  String? aboutOwner;
  String? status;
  Category? category;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Residence({
    this.id,
    this.residenceName,
    this.photo,
    this.capacity,
    this.beds,
    this.baths,
    this.address,
    this.city,
    this.municipality,
    this.quirtier,
    this.aboutResidence,
    this.hourlyAmount,
    this.popularity,
    this.ratings,
    this.dailyAmount,
    this.amenities,
    this.ownerName,
    this.hostId,
    this.aboutOwner,
    this.status,
    this.category,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Residence.fromJson(Map<String, dynamic> json) => Residence(
    id: json["_id"],
    residenceName: json["residenceName"],
    photo: json["photo"] == null ? [] : List<Photo>.from(json["photo"]!.map((x) => Photo.fromJson(x))),
    capacity: json["capacity"],
    beds: json["beds"],
    baths: json["baths"],
    address: json["address"],
    city: json["city"],
    municipality: json["municipality"],
    quirtier: json["quirtier"],
    aboutResidence: json["aboutResidence"],
    hourlyAmount: json["hourlyAmount"],
    popularity: json["popularity"],
    ratings: json["ratings"],
    dailyAmount: json["dailyAmount"],
    amenities: json["amenities"] == null ? [] : List<Category>.from(json["amenities"]!.map((x) => Category.fromJson(x))),
    ownerName: json["ownerName"],
    hostId: json["hostId"],
    aboutOwner: json["aboutOwner"],
    status: json["status"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "residenceName": residenceName,
    "photo": photo == null ? [] : List<dynamic>.from(photo!.map((x) => x.toJson())),
    "capacity": capacity,
    "beds": beds,
    "baths": baths,
    "address": address,
    "city": city,
    "municipality": municipality,
    "quirtier": quirtier,
    "aboutResidence": aboutResidence,
    "hourlyAmount": hourlyAmount,
    "popularity": popularity,
    "ratings": ratings,
    "dailyAmount": dailyAmount,
    "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x.toJson())),
    "ownerName": ownerName,
    "hostId": hostId,
    "aboutOwner": aboutOwner,
    "status": status,
    "category": category?.toJson(),
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Category {
  Translation? translation;
  String? id;

  Category({
    this.translation,
    this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    translation: json["translation"] == null ? null : Translation.fromJson(json["translation"]),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "translation": translation?.toJson(),
    "_id": id,
  };
}

class Translation {
  String? en;
  String? fr;

  Translation({
    this.en,
    this.fr,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    en: json["en"],
    fr: json["fr"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "fr": fr,
  };
}

class Photo {
  String? publicFileUrl;
  String? path;

  Photo({
    this.publicFileUrl,
    this.path,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    publicFileUrl: json["publicFileUrl"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileUrl": publicFileUrl,
    "path": path,
  };
}
