// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

import 'dart:convert';

Model modelFromJson(String str) => Model.fromJson(json.decode(str));

String modelToJson(Model data) => json.encode(data.toJson());

class Model {
    Model({
        this.placeId,
        this.licence,
        this.osmType,
        this.osmId,
        this.lat,
        this.lon,
        this.displayName,
        this.address,
        this.boundingbox,
    });

    int? placeId;
    String? licence;
    String? osmType;
    int? osmId;
    String? lat;
    String? lon;
    String? displayName;
    Address? address;
    List<String?>? boundingbox;

    factory Model.fromJson(Map<String, dynamic> json) => Model(
        placeId: json["place_id"],
        licence: json["licence"],
        osmType: json["osm_type"],
        osmId: json["osm_id"],
        lat: json["lat"],
        lon: json["lon"],
        displayName: json["display_name"],
        address: Address.fromJson(json["address"]),
        boundingbox: List<String>.from(json["boundingbox"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "place_id": placeId,
        "licence": licence,
        "osm_type": osmType,
        "osm_id": osmId,
        "lat": lat,
        "lon": lon,
        "display_name": displayName,
        "address": address!.toJson(),
        "boundingbox": List<dynamic>.from(boundingbox!.map((x) => x)),
    };
}

class Address {
    Address({
        this.road,
        this.neighbourhood,
        this.hamlet,
        this.village,
        this.county,
        this.stateDistrict,
        this.state,
        this.iso31662Lvl4,
        this.postcode,
        this.country,
        this.countryCode,
    });

    String? road;
    String? neighbourhood;
    String? hamlet;
    String? village;
    String? county;
    String? stateDistrict;
    String? state;
    String? iso31662Lvl4;
    String? postcode;
    String? country;
    String? countryCode;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        road: json["road"],
        neighbourhood: json["neighbourhood"],
        hamlet: json["hamlet"],
        village: json["village"],
        county: json["county"],
        stateDistrict: json["state_district"],
        state: json["state"],
        iso31662Lvl4: json["ISO3166-2-lvl4"],
        postcode: json["postcode"],
        country: json["country"],
        countryCode: json["country_code"],
    );

    Map<String, dynamic> toJson() => {
        "road": road,
        "neighbourhood": neighbourhood,
        "hamlet": hamlet,
        "village": village,
        "county": county,
        "state_district": stateDistrict,
        "state": state,
        "ISO3166-2-lvl4": iso31662Lvl4,
        "postcode": postcode,
        "country": country,
        "country_code": countryCode,
    };
}
