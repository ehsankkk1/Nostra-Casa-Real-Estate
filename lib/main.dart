import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:nostra_casa/business_logic/user/user_bloc.dart';
import 'package:nostra_casa/presentation/map_screen/widgets/markers.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:nostra_casa/utility/app_bloc_observer.dart';
import 'package:nostra_casa/utility/app_router.dart';
import 'package:nostra_casa/utility/app_style.dart';
import 'package:nostra_casa/utility/constant_logic_validations.dart';

void main() {
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;

  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = false;
  }

  Bloc.observer = MyBlocObserver();

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translation',
    startLocale: const Locale('en'),
    fallbackLocale: const Locale('en'),
    child: MyApp(appRouter: AppRouter()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({required this.appRouter, super.key});

  final AppRouter appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    MapsMarkers.initMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(CheckUserFromLocalStorage()),
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        navigatorKey: globalNavigatorKey,
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: AppStyle.theme,
        onGenerateRoute: widget.appRouter.onGenerateRoute,
      ),
    );
  }
}
