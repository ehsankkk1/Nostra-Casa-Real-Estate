import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nostra_casa/presentation/global_widgets/dialogs_widgets/dialogs_yes_no.dart';
import 'package:nostra_casa/utility/app_assets.dart';
import 'package:nostra_casa/utility/app_routes.dart';

import '../../utility/app_style.dart';
import '../../utility/constant_logic_validations.dart';
import '../global_widgets/elevated_button_widget.dart';

class WelcomeStep extends StatefulWidget {
  const WelcomeStep({Key? key}) : super(key: key);

  @override
  State<WelcomeStep> createState() => _WelcomeStepState();
}

class _WelcomeStepState extends State<WelcomeStep> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppStyle.kBackGroundColor,
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.038,
                    vertical: screenWidth * 0.038),
                child: const Image(
                  image: AssetImage(AppAssets.internalHouse),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.038,
                    vertical: screenWidth * 0.038),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tell us about your place'.tr(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      "Welcome to our platform! Add your property effortlessly and connect with potential renters or buyers. Start maximizing your property's potential today!"
                          .tr(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(
            left: screenWidth * 0.038, right: screenWidth * 0.038),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButtonWidget(
              title: "Add Now".tr(),
              onPressed: () {
                if(!userIsLoggedIn(context)){
                  DialogsWidgetsYesNo.showYesNoDialog(
                    title: "You must login to continue",
                    noTitle: "Cancel",
                    yesTitle: "Login",
                    onYesTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(AppRoutes.login);
                    },
                    onNoTap: () {
                      Navigator.of(context).pop();
                    },
                    context: context,
                  );
                  return;
                }
                Navigator.of(context).pushNamed(AppRoutes.addProperty);
              },
            )
          ],
        ),
      ),
    );
  }
}
