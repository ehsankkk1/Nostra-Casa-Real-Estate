import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nostra_casa/business_logic/add_property_bloc/add_property_bloc.dart';
import 'package:nostra_casa/business_logic/agency_promotion_status/agency_promotion_status_bloc.dart';
import 'package:nostra_casa/business_logic/amenity_bloc/amenity_bloc.dart';
import 'package:nostra_casa/business_logic/get_property_reviews/get_property_reviews_bloc.dart';
import 'package:nostra_casa/business_logic/get_report_categories/report_categories_bloc.dart';
import 'package:nostra_casa/business_logic/google_maps/google_maps_bloc.dart';
import 'package:nostra_casa/business_logic/my_property_action/my_property_action_bloc.dart';
import 'package:nostra_casa/business_logic/my_rating/my_rating_bloc.dart';
import 'package:nostra_casa/business_logic/notifications/notifications_bloc.dart';
import 'package:nostra_casa/business_logic/rate_property/rate_property_bloc.dart';
import 'package:nostra_casa/business_logic/send_property_bloc/send_property_bloc.dart';
import 'package:nostra_casa/data/models/properties_model.dart';
import 'package:nostra_casa/data/models/user_model.dart';
import 'package:nostra_casa/presentation/add_property/add_property_home.dart';
import 'package:nostra_casa/presentation/edit_profile/edit_profile.dart';
import 'package:nostra_casa/presentation/favorite_screen/favorite_screen.dart';
import 'package:nostra_casa/presentation/more/more_screen.dart';
import 'package:nostra_casa/presentation/promote_to_agency/promote_to_agency.dart';
import 'package:nostra_casa/presentation/promote_to_agency/welcome_to_promote.dart';
import 'package:nostra_casa/presentation/review_property/review_property_screen.dart';
import 'package:nostra_casa/presentation/signup/signup.dart';
import 'package:nostra_casa/presentation/verification_screen/code_verification_screen.dart';
import 'package:nostra_casa/presentation/view_agency/view_agency.dart';
import 'package:nostra_casa/presentation/view_property/view_property.dart';
import 'package:nostra_casa/presentation/view_property/widgets/virtual_reality_screen_view.dart';
import 'package:nostra_casa/presentation/welcome/welcome.dart';
import '../business_logic/add_to_favorite/add_favorite_bloc.dart';
import '../business_logic/country_bloc/country_bloc.dart';
import '../business_logic/edit_user_bloc/edit_user_bloc.dart';
import '../business_logic/promote_to_agency/promote_to_agency_bloc.dart';
import '../business_logic/send_report_bloc/send_report_bloc.dart';
import '../business_logic/tag_bloc/tag_bloc.dart';
import '../business_logic/user/user_bloc.dart';
import '../presentation/about_us/about_us.dart';
import '../presentation/add_property/welcome_step.dart';
import '../presentation/bottom_nav_bar/bottom_nav_bar.dart';
import '../presentation/explore/explore.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/my_properties/my_properties.dart';
import '../presentation/notifications/notifications.dart';
import '../presentation/policy/policy.dart';
import '../presentation/report_user_screen/report_user_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/view_property/widgets/google_maps_street_view.dart';
import '../presentation/view_property/widgets/images_staggered_view.dart';
import 'app_routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case AppRoutes.splashScreen:
          return const SplashScreen();

        case AppRoutes.welcome:
          return const WelcomeScreen();

        case AppRoutes.policy:
          return Policy(title: 'Usage and Privacy Policy');
        case AppRoutes.signup:
          return const SignUpScreen(title: 'Welcome');

        case AppRoutes.bottomNavBar:
          return const BottomNavBar();

        case AppRoutes.login:
          return const LoginScreen();

        case AppRoutes.verificationCode:
          SignUpEvent args = settings.arguments as SignUpEvent;
          return CodeVerificationScreenPage(signUpEvent: args);

        case AppRoutes.myProfile:
          return const MoreScreen();

        case AppRoutes.addPropertyWelcome:
          return const WelcomeStep();

        case AppRoutes.notifications:
          return BlocProvider(
            create: (context) =>
                NotificationsBloc()..add(ChangeToLoadingNotificatiosApiEvent()),
            child: Notifications(),
          );

        case AppRoutes.editProfile:
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => EditUserBloc(),
              ),
            ],
            child: const EditProfile(),
          );
        case AppRoutes.addProperty:
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AddPropertyBloc(),
              ),
              BlocProvider(
                create: (context) =>
                    AmenityBloc()..add(ChangeToLoadingApiEvent()),
              ),
              BlocProvider(
                create: (context) =>
                    TagBloc()..add(ChangeToLoadingTagApiEvent()),
              ),
              BlocProvider(
                create: (context) => CountryBloc()..add(GetCountryCityEvent()),
              ),
            ],
            child: const AddPropertyHome(),
          );
        case AppRoutes.aboutUs:
          return const AboutUs();

        case AppRoutes.viewProperty:
          Property args = settings.arguments as Property;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => OnePropertyBloc(),
              ),
              BlocProvider(
                create: (context) => RatePropertyBloc(),
              ),
              BlocProvider(
                create: (context) => GetPropertyReviewsBloc(),
              ),
              BlocProvider(
                create: (context) => MyRatingBloc(),
              ),
            ],
            child: ViewProperty(
              property: args,
            ),
          );

        case AppRoutes.reviewProperty:
          AddPropertyState args = settings.arguments as AddPropertyState;
          return BlocProvider(
            create: (context) => SendPropertyBloc(),
            child: ReviewProperty(addPropertyState: args),
          );

        case AppRoutes.homePage:
          return const Explore();

        case AppRoutes.virtualReality:
          return const VirtualRealityScreen();

        case AppRoutes.myProperties:
          return BlocProvider(
            create: (context) => MyPropertyActionBloc(),
            child: const MyProperties(),
          );

        case AppRoutes.viewAgency:
          UserInfo args = settings.arguments as UserInfo;
          return ViewAgency(
            userInfo: args,
          );

        case AppRoutes.staggeredImagesView:
          List<String> args = settings.arguments as List<String>;
          return ImagesStaggeredView(images: args);

        case AppRoutes.streetViewMaps:
          LatLng args = settings.arguments as LatLng;
          return StreetViewPanoramaInitDemo(
            initial: args,
          );

        case AppRoutes.welcomeToPromote:
          return BlocProvider(
            create: (context) =>
                AgencyPromotionStatusBloc()..add(GetPromotionStatusEvent()),
            child: const WelcomeToPromote(),
          );
        case AppRoutes.promoteToAgency:
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => GoogleMapsBloc(),
              ),
              BlocProvider(create: (context) => PromoteToAgencyBloc())
            ],
            child: const PromoteToAgency(),
          );

        case AppRoutes.favoriteScreen:
          return const FavoriteScreen();

        case AppRoutes.reportScreen:
          UserInfo args = settings.arguments as UserInfo;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    ReportCategoriesBloc()..add(GetReportCategoryEvent()),
              ),
              BlocProvider(
                create: (context) => SendReportBloc(),
              ),
            ],
            child: ReportUserScreen(
              userInfo: args,
            ),
          );

        default:
          return const Scaffold(
            body: Center(
              child: Text(
                'Check Named Route',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
          );
      }
    });
  }
}
