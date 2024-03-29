part of 'get_all_properties_bloc.dart';

abstract class GetAllPropertiesState extends Equatable {
  const GetAllPropertiesState();
}

class AllPropertiesInitial extends GetAllPropertiesState {
  @override
  List<Object> get props => [];
}
class AllPropertiesLoadedState extends GetAllPropertiesState {
  List<Property> properties;
  bool hasReachedMax;

  AllPropertiesLoadedState(
      {this.properties = const <Property>[],
        required this.hasReachedMax});

  AllPropertiesLoadedState copyWith({
    List<Property>? properties,
    bool? hasReachedMax,
  }) {
    return AllPropertiesLoadedState(
      properties: properties ?? this.properties,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [properties, hasReachedMax];
}
class AllPropertiesErrorState extends GetAllPropertiesState{

  AllPropertiesErrorState({required this.helperResponse});

  HelperResponse helperResponse;

  @override
  List<Object> get props => [helperResponse.servicesResponse,helperResponse.response];

}