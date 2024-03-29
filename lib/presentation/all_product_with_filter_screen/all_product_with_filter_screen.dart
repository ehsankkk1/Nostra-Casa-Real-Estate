import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../business_logic/get_properties/get_all-properties_search_filter.dart';
import '../../business_logic/get_properties/get_all_properties_bloc.dart';
import '../../business_logic/tag_bloc/tag_bloc.dart';
import '../../data/models/tags_model.dart';
import '../../utility/app_assets.dart';
import '../../utility/app_style.dart';
import '../explore/widgets/filter_spacer_widget.dart';
import '../explore/widgets/handle_widget.dart';
import '../explore/widgets/property_service_filter_widget.dart';
import '../explore/widgets/property_type_filter_widget.dart';
import '../explore/widgets/search_text_field.dart';
import '../explore/widgets/sorts_filter_widget.dart';
import '../global_widgets/elevated_button_widget.dart';
import '../global_widgets/property_widgets/property_list_view.dart';
import '../global_widgets/property_widgets/property_shimmer.dart';
import '../global_widgets/somthing_wrong.dart';

class AllProductsWithFilterScreen extends StatefulWidget {
  AllProductsWithFilterScreen({required this.propertiesSearchFilter, Key? key})
      : super(key: key);
  GetAllPropertiesSearchFilter propertiesSearchFilter;
  @override
  State<AllProductsWithFilterScreen> createState() =>
      _AllProductsWithFilterScreenState();
}

class _AllProductsWithFilterScreenState
    extends State<AllProductsWithFilterScreen> {
  TextEditingController searchController = TextEditingController();

  bool showSearchDeleteIcon = false;

  ScrollController scrollController = ScrollController();

  GetAllPropertiesBloc propertiesBloc = GetAllPropertiesBloc();

  late GetAllPropertiesSearchFilter propertiesSearchFilter;

  @override
  void initState() {
    propertiesSearchFilter =
        widget.propertiesSearchFilter;
    print(propertiesSearchFilter.myFavorite);
    search();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        propertiesBloc.add(
          GetAllPropertiesApiEvent(
            searchFilterProperties: propertiesSearchFilter,
          ),
        );
      }
    });
    super.initState();
  }

  void search() {
    propertiesBloc.add(ChangeToLoadingApiEvent(
      searchFilterProperties: propertiesSearchFilter,
    ));
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: propertiesBloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: AppStyle.kBackGroundColor,
        appBar: AppBar(
          title: const Text("My Favorite"),
        ),
        body: BlocBuilder<GetAllPropertiesBloc, GetAllPropertiesState>(
          builder: (context, getAllState) {
            if (getAllState is AllPropertiesInitial) {
              return ListView(
                children: [
                  PropertyShimmer(),
                  PropertyShimmer(),
                ],
              );
            }
            if (getAllState is AllPropertiesLoadedState &&
                getAllState.properties.isEmpty) {
              return SomethingWrongWidget(
                title: "No properties found !".tr(),
                svgPath: AppAssets.search,
                elevatedButtonWidget: ElevatedButtonWidget(
                  title: "Refresh".tr(),
                  onPressed: () {
                    search();
                  },
                ),
              );
            }
            if (getAllState is AllPropertiesLoadedState) {
              return RefreshIndicator(
                onRefresh: () async {
                  search();
                },
                child: AllPropertyListView(
                  hasReachedMax: getAllState.hasReachedMax,
                  properties: getAllState.properties,
                  scrollController: scrollController,
                ),
              );
            }
            return SomethingWrongWidget(
              elevatedButtonWidget: ElevatedButtonWidget(
                title: "Refresh".tr(),
                onPressed: () {
                  search();
                },
              ),
            );
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Filter FAB
            FloatingActionButton(
              heroTag: "asdasdasd",
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    shape: AppStyle.k10TopBorderRectangle,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const HandleWidget(),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SearchTextField(
                                        onClear: () {
                                          searchController.clear();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          Navigator.of(context).pop();

                                          setState(() {
                                            propertiesSearchFilter =
                                                propertiesSearchFilter.copyWith(
                                                    term: "");
                                            showSearchDeleteIcon = false;
                                          });
                                          search();
                                        },
                                        onSend: (value) {
                                          if (value == null || value.isEmpty) {
                                            return;
                                          }
                                          Navigator.of(context).pop();

                                          setState(() {
                                            propertiesSearchFilter =
                                                propertiesSearchFilter.copyWith(
                                                    term: value);
                                            showSearchDeleteIcon = true;
                                          });
                                          search();
                                        },
                                        searchController: searchController,
                                        showSearchDeleteIcon:
                                            showSearchDeleteIcon,
                                      ),
                                      const FilterSpacing(),
                                      PropertyTypeFilterExploreWidget(
                                        onChanged: (value) {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            propertiesSearchFilter =
                                                propertiesSearchFilter.copyWith(
                                                    propertyType: value);
                                          });
                                          search();
                                        },
                                        value:
                                            propertiesSearchFilter.propertyType,
                                      ),
                                      const FilterSpacing(),
                                      PropertyServiceFilterExploreWidget(
                                        onChanged: (value) {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            propertiesSearchFilter =
                                                propertiesSearchFilter.copyWith(
                                                    propertyService: value);
                                          });
                                          search();
                                        },
                                        value: propertiesSearchFilter
                                            .propertyService,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    });
              },
              backgroundColor: AppStyle.mainColor,
              child: SizedBox(
                child: SvgPicture.asset(
                  AppAssets.search,
                  color: AppStyle.kBackGroundColor,
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            // Sort FAB
            FloatingActionButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: AppStyle.k10TopBorderRectangle,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return SortsFilterWidget(
                            value: propertiesSearchFilter.propertySorts,
                            onChanged: (value) {
                              Navigator.of(context).pop();
                              setState(() {
                                propertiesSearchFilter = propertiesSearchFilter
                                    .copyWith(propertySorts: value);
                              });
                              search();
                            },
                          );
                        },
                      );
                    });
              },
              backgroundColor: AppStyle.mainColor,
              child: SizedBox(
                child: SvgPicture.asset(
                  AppAssets.filter,
                  color: AppStyle.kBackGroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
