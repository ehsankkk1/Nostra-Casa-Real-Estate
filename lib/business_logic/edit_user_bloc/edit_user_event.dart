part of 'edit_user_bloc.dart';

abstract class EditUserEvent extends Equatable {
  const EditUserEvent();
}

class EditUserApiEvent extends EditUserEvent {
  EditUserApiEvent(
      {
        required this.email,
        required this.fullName,
        required this.gender,
          this.facebook,
          this.dateOfBirth,

      });
  String email;
  String fullName;
  Gender gender;
  String? facebook;
  String? dateOfBirth;


  Map<String, dynamic> toJson() {
    final json = {
      "name": fullName,
      "email": email,
      "gender": gender.name,
      "facebook": facebook,
      "date_of_birth": dateOfBirth,
    };
    json.removeWhere((key, value) => value==null||value ==""||value.isEmpty||value=="null");
    return json;
  }

  @override
  List<Object?> get props =>
      [ email, fullName, gender,facebook,dateOfBirth];
}