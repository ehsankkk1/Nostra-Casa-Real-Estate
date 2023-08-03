

enum ServicesResponseStatues {
  success,
  networkError,
  savedToLocal,
  someThingWrong,
  modelError,
  wrongData,
  locationError,
}
enum PropertyType {
  residential,
  agricultural,
  commercial,
  all,
}

enum PropertyService {
  sale,
  rent,
  holiday,
}
final serviceValues = EnumValues({
  "Sent Successfully" : ServicesResponseStatues.success,
  "Connection error !": ServicesResponseStatues.networkError,
  "Something went wrong !": ServicesResponseStatues.someThingWrong,
  "Failed to parse model !": ServicesResponseStatues.modelError,
  "Data sent is not correct !":ServicesResponseStatues.wrongData,
  "The form is saved locally":ServicesResponseStatues.savedToLocal,
  "No Location Permission !":ServicesResponseStatues.locationError
});

final propertyTypeUi = EnumValues({
  "Residential" : PropertyType.residential,
  "Agricultural": PropertyType.agricultural,
  "Commercial": PropertyType.commercial,
});
final propertyTypeBackEnd = EnumValues({
  "RESIDENTIAL" : PropertyType.residential,
  "AGRICULTURAL": PropertyType.agricultural,
  "COMMERCIAL": PropertyType.commercial,
});
final propertyService = EnumValues({
  "Sale" : PropertyService.sale,
  "Rent": PropertyService.rent,
  "Holiday": PropertyService.holiday,
});

enum GetRequestType{
  contactInfo,
}
enum Gender { male, female }
final genderValues = EnumValues({
  "male": Gender.male,
  "female": Gender.female,
});


class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
