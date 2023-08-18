

import '../../business_logic/my_property_action/my_property_action_bloc.dart';
import '../../utility/endpoints.dart';
import '../../utility/enums.dart';
import '../../utility/network_helper.dart';

class PropertyActionService{


  static Future deletePropertyService({
    required DeletePropertyEvent event,
  }) async {
    String getEndPoint(){
      if(event.propertyType == PropertyType.agricultural){
        return EndPoints.deleteAgriculturalProperty(event.propertyId);
      }
      if(event.propertyType == PropertyType.residential){
        return EndPoints.deleteResidentialProperty(event.propertyId);
      }
      return EndPoints.deleteCommercialProperty(event.propertyId);
    }
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url:getEndPoint(),
      useUserToken: true,
      crud: "DELETE"
    );
    print(helperResponse.response);

    return helperResponse;

  }
}