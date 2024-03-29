import 'package:easy_localization/easy_localization.dart';

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
  all,
}
enum PropertyMarketStatus{
  inMarket,
  purchased,
  rented,
}
enum PropertySorts {
  newToOld,
  oldToNew,
  priceHigh,
  priceLow,
  areaHigh,
  areaLow,
  suggested
}
enum Gender { male, female }
enum GetPropertiesApi{
  myFavorite,
  getAll,
}
final EnumValues propertySortsUi = EnumValues({
  "Price (low to high)": PropertySorts.priceHigh,
  "Price (high to low)": PropertySorts.priceLow,
  "New To Old": PropertySorts.newToOld,
  "Old To New": PropertySorts.oldToNew,
  "Area (low to high)": PropertySorts.areaHigh,
  "Area (high to low)": PropertySorts.areaLow,
  "Suggested Dealers": PropertySorts.suggested,

});
final EnumValues propertySortsUBackEnd = EnumValues({
  "price": PropertySorts.priceHigh,
  "-price": PropertySorts.priceLow,
  "created-at": PropertySorts.oldToNew,
  "-created-at": PropertySorts.newToOld,
  "area": PropertySorts.areaHigh,
  "-area": PropertySorts.areaLow,
  "owner-priority": PropertySorts.suggested,

});
final EnumValues serviceValues = EnumValues({
  "Sent Successfully": ServicesResponseStatues.success,
  "Connection error !": ServicesResponseStatues.networkError,
  "Something went wrong !": ServicesResponseStatues.someThingWrong,
  "Failed to parse model !": ServicesResponseStatues.modelError,
  "Data sent is not correct !": ServicesResponseStatues.wrongData,
  "The form is saved locally": ServicesResponseStatues.savedToLocal,
  "No Location Permission !": ServicesResponseStatues.locationError
});

final EnumValues propertyTypeUi = EnumValues({
  "Residential".tr(): PropertyType.residential,
  "Agricultural".tr(): PropertyType.agricultural,
  "Commercial".tr(): PropertyType.commercial,
  "All Property Types".tr(): PropertyType.all,
});
final EnumValues propertyTypeBackEnd = EnumValues({
  "RESIDENTIAL": PropertyType.residential,
  "AGRICULTURAL": PropertyType.agricultural,
  "COMMERCIAL": PropertyType.commercial,
});
final EnumValues propertyTypeBackEnd2 = EnumValues({
  "residential": PropertyType.residential,
  "agricultural": PropertyType.agricultural,
  "commercial": PropertyType.commercial,
});


final propertyServiceUI = EnumValues({
  "Sale".tr(): PropertyService.sale,
  "Rent".tr(): PropertyService.rent,
  "Holiday".tr(): PropertyService.holiday,
  "All Property Services".tr(): PropertyService.all,
});
final propertyServicePriceUI = EnumValues({
  " total".tr(): PropertyService.sale,
  " per month".tr(): PropertyService.rent,
  " per day".tr(): PropertyService.holiday,
});
final EnumValues propertyServiceBackEnd1 = EnumValues({
  "SALE": PropertyService.sale,
  "RENT": PropertyService.rent,
  "HOLIDAY": PropertyService.holiday,
});
final EnumValues propertyServiceBackEnd2 = EnumValues({
  "sale": PropertyService.sale,
  "rent": PropertyService.rent,
  "holiday": PropertyService.holiday,
});


final EnumValues propertyMarketUi = EnumValues({
  "In Market".tr(): PropertyMarketStatus.inMarket,
  "Property is purchased".tr(): PropertyMarketStatus.purchased,
  "Rented for now".tr(): PropertyMarketStatus.rented,
});
final EnumValues propertyMarketBackEnd = EnumValues({
  "IN_MARKET": PropertyMarketStatus.inMarket,
  "PURCHASED": PropertyMarketStatus.purchased,
  "RENTED": PropertyMarketStatus.rented,
});
final EnumValues propertyMarketBackEnd2 = EnumValues({
  "in_market": PropertyMarketStatus.inMarket,
  "purchased": PropertyMarketStatus.purchased,
  "rented": PropertyMarketStatus.rented,
});


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
