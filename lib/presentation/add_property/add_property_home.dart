import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nostra_casa/presentation/add_property/screens/add_property_description.dart';
import 'package:nostra_casa/presentation/add_property/screens/add_property_images.dart';
import 'package:nostra_casa/presentation/add_property/screens/add_property_price_and_space.dart';
import 'package:nostra_casa/presentation/add_property/screens/add_property_title.dart';
import 'package:nostra_casa/presentation/add_property/screens/add_region.dart';
import 'package:nostra_casa/presentation/add_property/screens/amenity/choose_amenities.dart';
import 'package:nostra_casa/presentation/add_property/screens/choose_attributes/choose_property_type_attributes.dart';
import 'package:nostra_casa/presentation/add_property/screens/choose_service.dart';
import 'package:nostra_casa/presentation/add_property/screens/tag/choose_tags.dart';
import 'package:nostra_casa/presentation/add_property/screens/choose_type.dart';
import 'package:nostra_casa/presentation/add_property/screens/pin_google_map_screen/GoogleMapsScreen.dart';
import 'package:nostra_casa/presentation/add_property/widgets/add_property_bottom_navigator.dart';
import 'package:nostra_casa/utility/app_routes.dart';
import '../../business_logic/add_property_bloc/add_property_bloc.dart';
import '../global_widgets/dialogs_widgets/dialogs_yes_no.dart';

class AddPropertyHome extends StatefulWidget {
  const AddPropertyHome({super.key});

  @override
  AddPropertyHomeState createState() => AddPropertyHomeState();
}

class AddPropertyHomeState extends State<AddPropertyHome> {
  int screensNumber = 10;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  bool isDisabledNext() {
    final addPropertyBloc = context.watch<AddPropertyBloc>();

    if (addPropertyBloc.state.selectedTag.isEmpty && stepNumber == 0) {
      return true;
    }
    if (addPropertyBloc.state.selectedPropertyType == null && stepNumber == 1) {
      return true;
    }
    if (addPropertyBloc.state.propertyService == null && stepNumber == 2) {
      return true;
    }
    if (addPropertyBloc.state.selectedAmenity.isEmpty && stepNumber == 4) {
      return true;
    }
    if (addPropertyBloc.state.images.length < 3 && stepNumber == 5) {
      return true;
    }
    if (addPropertyBloc.state.selectedLocation == null && stepNumber == 7) {
      return true;
    }
    if (addPropertyBloc.state.title.length < 5 && stepNumber == 8) {
      return true;
    }
    if (addPropertyBloc.state.description.length < 5 && stepNumber == 9) {
      return true;
    }

    return false;
  }

  bool isDisabledBack() {
    if (stepNumber == 0) {
      return true;
    }
    return false;
  }

  void onSubmit() {
    final addPropertyBloc = context.read<AddPropertyBloc>();
    Navigator.of(context)
        .pushNamed(AppRoutes.reviewProperty, arguments: addPropertyBloc.state);
  }

  @override
  void dispose() {
    super.dispose();
  }

  final SharedAxisTransitionType _transitionType =
      SharedAxisTransitionType.horizontal;
  int stepNumber = 0;
  bool isReverse = false;

  Future<bool> onWillPopMethod() async {
    return DialogsWidgetsYesNo.onWillPopMethod(context);
  }

  @override
  Widget build(BuildContext context) {
    final progress = (stepNumber * 100) / screensNumber;
    return WillPopScope(
      onWillPop: onWillPopMethod,
      child: Scaffold(
          appBar: AppBar(),
          body: PageTransitionSwitcher(
            duration: const Duration(milliseconds: 600),
            reverse:
                context.locale.languageCode == 'ar' ? !isReverse : isReverse,
            transitionBuilder: (Widget child, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: _transitionType,
                child: child,
              );
            },
            child: Builder(
                key: Key(stepNumber.toString()),
                builder: (context) {
                  if (stepNumber == 0) {
                    return const ChooseTags();
                  }
                  if (stepNumber == 1) {
                    return const ChooseType();
                  }
                  if (stepNumber == 2) {
                    return const ChooseService();
                  }
                  if (stepNumber == 3) {
                    return const ChoosePropertyTypeAttributes();
                  }
                  if (stepNumber == 4) {
                    return const ChooseAmenities();
                  }
                  if (stepNumber == 5) {
                    return const AddPropertyImages();
                  }
                  if (stepNumber == 6) {
                    return const AddRegion();
                  }
                  if (stepNumber == 7) {
                    return const GoogleMapsScreen();
                  }
                  if (stepNumber == 8) {
                    return AddPropertyTitle();
                  }
                  if (stepNumber == 9) {
                    return AddPropertyDescription();
                  }
                  if (stepNumber == 10) {
                    return const AddPropertyPriceAndSpace();
                  }
                  return const Scaffold(
                    body: Center(
                      child: Text(
                        'Check Named Route',
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                  );
                }),
          ),
          bottomNavigationBar: AddPropertyBottomNavigator(
            onPressedBack: isDisabledBack()
                ? null
                : () {
                    setState(() {
                      stepNumber--;
                    });
                  },
            onPressedNext: isDisabledNext()
                ? null
                : () {
                    setState(() {
                      stepNumber++;
                    });
                  },
            progress: progress,
            stepNumber: stepNumber,
            onSubmit: onSubmit,
          )),
    );
  }
}
