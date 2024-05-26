class YandexPlacesModel {
  YandexPlacesModel({
    required this.features,
  });

  final List<Feature> features;

  factory YandexPlacesModel.fromJson(Map<String, dynamic> json) {
    return YandexPlacesModel(
      features: json["features"] == null
          ? []
          : List<Feature>.from(
              json["features"]!.map((x) => Feature.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "features": features.map((x) => x?.toJson()).toList(),
      };
}

class Feature {
  Feature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  final String type;
  final Geometry? geometry;
  final Properties? properties;

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      type: json["type"] ?? "",
      geometry:
          json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
      properties: json["properties"] == null
          ? null
          : Properties.fromJson(json["properties"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "geometry": geometry?.toJson(),
        "properties": properties?.toJson(),
      };
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  final String type;
  final List<double> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      type: json["type"] ?? "",
      coordinates: json["coordinates"] == null
          ? []
          : List<double>.from(json["coordinates"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates.map((x) => x).toList(),
      };
}

class Properties {
  Properties({
    required this.name,
    required this.description,
    required this.boundedBy,
    required this.uri,
    required this.companyMetaData,
  });

  final String name;
  final String description;
  final List<List<double>> boundedBy;
  final String uri;
  final CompanyMetaData? companyMetaData;

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      boundedBy: json["boundedBy"] == null
          ? []
          : List<List<double>>.from(json["boundedBy"]!.map(
              (x) => x == null ? [] : List<double>.from(x!.map((x) => x)))),
      uri: json["uri"] ?? "",
      companyMetaData: json["CompanyMetaData"] == null
          ? null
          : CompanyMetaData.fromJson(json["CompanyMetaData"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "boundedBy": boundedBy.map((x) => x.map((x) => x).toList()).toList(),
        "uri": uri,
        "CompanyMetaData": companyMetaData?.toJson(),
      };
}

class CompanyMetaData {
  CompanyMetaData({
    required this.id,
    required this.name,
    required this.address,
    required this.url,
    required this.phones,
    required this.categories,
    required this.hours,
  });

  final String id;
  final String name;
  final String address;
  final String url;
  final List<Phone> phones;
  final List<Category> categories;
  final Hours? hours;

  factory CompanyMetaData.fromJson(Map<String, dynamic> json) {
    return CompanyMetaData(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      address: json["address"] ?? "",
      url: json["url"] ?? "",
      phones: json["Phones"] == null
          ? []
          : List<Phone>.from(json["Phones"]!.map((x) => Phone.fromJson(x))),
      categories: json["Categories"] == null
          ? []
          : List<Category>.from(
              json["Categories"]!.map((x) => Category.fromJson(x))),
      hours: json["Hours"] == null ? null : Hours.fromJson(json["Hours"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "url": url,
        "Phones": phones.map((x) => x?.toJson()).toList(),
        "Categories": categories.map((x) => x?.toJson()).toList(),
        "Hours": hours?.toJson(),
      };
}

class Category {
  Category({
    required this.categoryClass,
    required this.name,
  });

  final String categoryClass;
  final String name;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryClass: json["class"] ?? "",
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "class": categoryClass,
        "name": name,
      };
}

class Hours {
  Hours({
    required this.text,
    required this.availabilities,
  });

  final String text;
  final List<Availability> availabilities;

  factory Hours.fromJson(Map<String, dynamic> json) {
    return Hours(
      text: json["text"] ?? "",
      availabilities: json["Availabilities"] == null
          ? []
          : List<Availability>.from(
              json["Availabilities"]!.map((x) => Availability.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "text": text,
        "Availabilities": availabilities.map((x) => x?.toJson()).toList(),
      };
}

class Availability {
  Availability({
    required this.intervals,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  final List<Interval> intervals;
  final bool monday;
  final bool tuesday;
  final bool wednesday;
  final bool thursday;
  final bool friday;
  final bool saturday;
  final bool sunday;

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      intervals: json["Intervals"] == null
          ? []
          : List<Interval>.from(
              json["Intervals"]!.map((x) => Interval.fromJson(x))),
      monday: json["Monday"] ?? false,
      tuesday: json["Tuesday"] ?? false,
      wednesday: json["Wednesday"] ?? false,
      thursday: json["Thursday"] ?? false,
      friday: json["Friday"] ?? false,
      saturday: json["Saturday"] ?? false,
      sunday: json["Sunday"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "Intervals": intervals.map((x) => x?.toJson()).toList(),
        "Monday": monday,
        "Tuesday": tuesday,
        "Wednesday": wednesday,
        "Thursday": thursday,
        "Friday": friday,
        "Saturday": saturday,
        "Sunday": sunday,
      };
}

class Interval {
  Interval({
    required this.from,
    required this.to,
  });

  final String from;
  final String to;

  factory Interval.fromJson(Map<String, dynamic> json) {
    return Interval(
      from: json["from"] ?? "",
      to: json["to"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
      };
}

class Phone {
  Phone({
    required this.type,
    required this.formatted,
  });

  final String type;
  final String formatted;

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      type: json["type"] ?? "",
      formatted: json["formatted"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "formatted": formatted,
      };
}
