import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nostra_casa/presentation/add_property/widgets/custom_elevated_button.dart';
import 'package:nostra_casa/presentation/add_property/widgets/images_list.dart';

import '../../../business_logic/add_property_bloc/add_property_bloc.dart';
import '../../../utility/app_style.dart';

class AddPropertyImages extends StatefulWidget {
  const AddPropertyImages({Key? key}) : super(key: key);

  @override
  State<AddPropertyImages> createState() => _AddPropertyImagesState();
}

class _AddPropertyImagesState extends State<AddPropertyImages> {
  List<File>? images;

  File? _cameraImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _chooseImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    setState(() {
      if (images != null) {
        images?.addAll(
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList());
      } else {
        images =
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      }

      context.read<AddPropertyBloc>().add(SelectedImagesEvent(images: images));
    });
  }

  Future<void> _takeImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _cameraImage = pickedFile != null ? File(pickedFile.path) : null;
      if (pickedFile != null) {
        final cameraImage = File(pickedFile.path);
        if (images == null) {
          images = [cameraImage];
        } else {
          images!.add(cameraImage);
        }
        context
            .read<AddPropertyBloc>()
            .add(SelectedImagesEvent(images: images));
      }
    });
  }
  void _removeImage(File image) {
    setState(() {
      images!.remove(image);
      context.read<AddPropertyBloc>().add(SelectedImagesEvent(images: images));
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppStyle.kBackGroundColor,
      body: Padding(
        padding: EdgeInsets.only(
            left: screenWidth * 0.038,
            right: screenWidth * 0.038,
            top: screenHeight * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Add some photos of your house'.tr(),
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              'You\'ll need 3 photos to get started. you can add more or make changes later.'
                  .tr(),
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: AppStyle.kGreyColor),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Expanded(
              child: Column(
                children: [
                  CustomElevatedButton(
                      onPress: _chooseImages,
                      title: "Add photos".tr(),
                      iconData: Icons.add),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  CustomElevatedButton(
                      onPress: _takeImage,
                      title: "Take new photos".tr(),
                      iconData: Icons.camera_alt_outlined),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Expanded(
                    child: ImagesList(
                      images: images,
                      onImageRemoved: _removeImage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
