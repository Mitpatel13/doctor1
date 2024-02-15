class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.qualifications,
    required this.specality,
    required this.address,
    required this.location,
    required this.regNumber,
    required this.experience,
    required this.referid,
    required this.subEnddate,
    required this.rating,
    required this.totalRating,
  });

  String id;
  String name;
  String qualifications;
  String specality;
  String address;
  Location location;
  String regNumber;
  String experience;
  String referid;
  String subEnddate;
  String phone;
  int rating;
  int totalRating;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        qualifications: json["qualifications"],
        specality: json["specality"],
        address: json["address"],
        location: Location.fromJson(json["location"]),
        regNumber: json["regNumber"],
        experience: json["experience"],
        referid: json["referid"],
        subEnddate: json["subEnddate"],
        rating: json["rating"],
        totalRating: json["totalRating"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "qualifications": qualifications,
        "specality": specality,
        "address": address,
        "location": location.toJson(),
        "regNumber": regNumber,
        "experience": experience,
        "referid": referid,
        "subEnddate": subEnddate,
        "rating": rating,
        "totalRating": totalRating,
      };
}

class Location {
  Location({
    required this.type,
    required this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}
