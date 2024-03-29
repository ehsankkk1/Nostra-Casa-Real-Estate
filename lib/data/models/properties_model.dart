import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nostra_casa/data/models/amenities_model.dart';
import 'package:nostra_casa/data/models/special_attributes.dart';
import 'package:nostra_casa/data/models/tags_model.dart';
import 'package:nostra_casa/data/models/user_model.dart';
import 'package:nostra_casa/utility/enums.dart';

import 'country_and_city_model.dart';

WelcomeProperties welcomePropertiesFromJson(String str) =>
    WelcomeProperties.fromJson(json.decode(str));

WelcomeProperties welcomePropertiesFromJson2(String str) =>
    WelcomeProperties.welcomeFromJson2(json.decode(str));

class WelcomeProperties {
  List<Property> properties;

  WelcomeProperties({
    required this.properties,
  });

  factory WelcomeProperties.fromJson(Map<String, dynamic> json) =>
      WelcomeProperties(
        properties:
            List<Property>.from(json["data"].map((x) => Property.fromJson(x))),
      );

  factory WelcomeProperties.welcomeFromJson2(Map<String, dynamic> json) =>
      WelcomeProperties(
        properties: List<Property>.from(
            json["data"]["data"].map((x) => Property.fromJson(x))),
      );
}

class Property {
  int id;
  String name;
  num area;
  num price;
  String description;
  LatLng location;
  String status;
  PropertyMarketStatus propertyMarketStatus;
  PropertyType propertyType;
  PropertyService? propertyService;
  List<Tag> tags;
  List<Amenity> amenities;
  UserInfo? userInfo;
  ResidentialPropertyAttributes? residential;
  CommercialPropertyAttributes? commercial;
  AgriculturalPropertyAttributes? agricultural;
  List<String> media;
  City? city;
  CountryModel? country;
  num rate;

  Property({
    this.id = -1,
    this.name = "",
    this.area = 0,
    this.price = 0,
    this.description = "",
    this.location = const LatLng(0, 0),
    this.status = '',
    this.propertyType = PropertyType.all,
    this.tags = const <Tag>[],
    this.amenities = const <Amenity>[],
    this.userInfo,
    this.agricultural,
    this.residential,
    this.commercial,
    this.media = const [""],
    this.propertyService,
    this.country,
    this.city,
    this.rate = 0,
    this.propertyMarketStatus = PropertyMarketStatus.inMarket,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      rate: json["rating"]??0,
      area: json["area"] ?? 0,
      price: json["price"] ?? 0,
      description: json["description"] ?? "",
      location: LatLng(double.tryParse(json["latitude"]) ?? 0,
          double.tryParse(json["longitude"]) ?? 0),
      status: json["status"] ?? '',
      propertyType: propertyTypeBackEnd2.map[json["type"]] ?? PropertyType.all,
      propertyService: propertyServiceBackEnd2.map[json["service"]],
      propertyMarketStatus: propertyMarketBackEnd2.map[json["status"]]??PropertyMarketStatus.inMarket,
      tags: List<Tag>.from(json["tags"]?.map((x) => Tag.fromJson(x)) ?? []),
      amenities: List<Amenity>.from(
          json["amenities"]?.map((x) => Amenity.fromJson(x)) ?? []),
      userInfo: json["user"] != null
          ? UserInfo.fromJson(json["user"])
          : UserInfo(id: -1),
      residential: json["residential"] != null
          ? ResidentialPropertyAttributes.fromJson(json["residential"])
          : null,
      commercial: json["commercial"] != null
          ? CommercialPropertyAttributes.fromJson(json["commercial"])
          : null,
      agricultural: json["agricultural"] != null
          ? AgriculturalPropertyAttributes.fromJson(json["agricultural"])
          : null,
      media: List<String>.from(
          json["media"]?.map((x) => x["original_url"]) ?? [""]),
      country: json["country"] != null
          ? CountryModel.fromJson(json["country"])
          : CountryModel(),
      city: json["city"] != null
        ? City.fromJson(json["city"])
        : City(),
    );
  }
}
