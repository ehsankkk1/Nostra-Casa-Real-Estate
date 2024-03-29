import 'package:nostra_casa/data/models/amenities_model.dart';
import 'package:nostra_casa/utility/constant_logic_validations.dart';

import '../../business_logic/amenity_bloc/amenity_bloc.dart';
import '../../utility/endpoints.dart';
import '../../utility/enums.dart';
import '../../utility/network_helper.dart';

class AmenityService {
  Future getAmenityService({
    required GetAmenityApiEvent event,
  }) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.getAmenities(
          page: event.searchFilterProperties.page,
          limit: kProductsGetLimit,
      ),
      useUserToken: false,
    );
    print(helperResponse.servicesResponse);

    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
      WelcomeAmenities data = welcomeAmenitiesFromJson(helperResponse.response);
      return data.amenities;
      } catch (e) {
        return helperResponse.copyWith(servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }
}
