import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nostra_casa/business_logic/add_property_bloc/add_property_bloc.dart';
import 'package:nostra_casa/utility/enums.dart';

import '../../data/services/add_property_service.dart';
import '../../utility/endpoints.dart';
import '../../utility/network_helper.dart';

part 'send_property_event.dart';
part 'send_property_state.dart';

class SendPropertyBloc extends Bloc<SendPropertyEvent, SendPropertyState> {
  SendPropertyBloc() : super(SendPropertyInitial()) {
    on<SendPropertyApiEvent>((event, emit) async {
      emit(SendPropertyLoading());

      PropertyType? propertyType = event.addPropertyState.selectedPropertyType;
      HelperResponse helperResponse;

      if (propertyType == PropertyType.agricultural) {
        helperResponse = await AddPropertyService.addPropertyService(
            endPoints: EndPoints.addAgricultural, event: event);

      }else if (propertyType == PropertyType.commercial) {
        helperResponse = await AddPropertyService.addPropertyService(
            endPoints: EndPoints.addCommercial, event: event);

      }else {
        helperResponse = await AddPropertyService.addPropertyService(
            endPoints: EndPoints.addResidential, event: event);

      }

      emit(SendPropertyStatus(helperResponse: helperResponse));

    });
  }
}
