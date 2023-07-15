import 'package:flutter/material.dart';
import 'package:nostra_casa/presentation/add_property/widgets/custom_grid.dart';
import 'package:nostra_casa/utility/app_assets.dart';

import '../../../utility/app_style.dart';

class ChooseTags extends StatefulWidget {
  const ChooseTags({Key? key}) : super(key: key);


  @override
  State<ChooseTags> createState() => _ChooseTagsState();
}

class _ChooseTagsState extends State<ChooseTags> {
  @override
  Widget build(BuildContext context) {
    final List<String> svgPaths=[AppAssets.house,AppAssets.house,AppAssets.house];
    final List<String> title=["House","House","House"];
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppStyle.kBackGroundColor,
      body: Padding(
        padding: EdgeInsets.only(
            left: screenWidth * 0.07,
            right: screenWidth * 0.07,
            top: screenHeight * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Which of these best describes your place?',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Expanded(
              child: CustomGrid(svgPaths: svgPaths, title: title,),
            ),
          ],
        ),
      ),
    );
  }
}
