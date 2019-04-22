// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String status;
  String copyright;
  int numResults;
  List<Result> results;

  Welcome({
    this.status,
    this.copyright,
    this.numResults,
    this.results,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => new Welcome(
    status: json["status"],
    copyright: json["copyright"],
    numResults: json["num_results"],
    results: new List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "copyright": copyright,
    "num_results": numResults,
    "results": new List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

List<Welcome> allPostsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Welcome>.from(jsonData.map((x) => Welcome.fromJson(x)));
}

String allPostsToJson(List<Welcome> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Result {
  String listName;
  String displayName;
  String listNameEncoded;
  DateTime oldestPublishedDate;
  DateTime newestPublishedDate;
  Updated updated;

  Result({
    this.listName,
    this.displayName,
    this.listNameEncoded,
    this.oldestPublishedDate,
    this.newestPublishedDate,
    this.updated,
  });

  factory Result.fromJson(Map<String, dynamic> json) => new Result(
    listName: json["list_name"],
    displayName: json["display_name"],
    listNameEncoded: json["list_name_encoded"],
    oldestPublishedDate: DateTime.parse(json["oldest_published_date"]),
    newestPublishedDate: DateTime.parse(json["newest_published_date"]),
    updated: updatedValues.map[json["updated"]],
  );

  Map<String, dynamic> toJson() => {
    "list_name": listName,
    "display_name": displayName,
    "list_name_encoded": listNameEncoded,
    "oldest_published_date": "${oldestPublishedDate.year.toString().padLeft(4, '0')}-${oldestPublishedDate.month.toString().padLeft(2, '0')}-${oldestPublishedDate.day.toString().padLeft(2, '0')}",
    "newest_published_date": "${newestPublishedDate.year.toString().padLeft(4, '0')}-${newestPublishedDate.month.toString().padLeft(2, '0')}-${newestPublishedDate.day.toString().padLeft(2, '0')}",
    "updated": updatedValues.reverse[updated],
  };
}

enum Updated { WEEKLY, MONTHLY }

final updatedValues = new EnumValues({
  "MONTHLY": Updated.MONTHLY,
  "WEEKLY": Updated.WEEKLY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
