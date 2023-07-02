
import 'package:flutter/material.dart';
import '../../policy.dart';


class GetSelectedScreenByIndex extends StatelessWidget {
  const GetSelectedScreenByIndex({required this.screenIndex,Key? key}) : super(key: key);
  final int screenIndex ;

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          if(screenIndex == 0){
            return Policy(title: 'From nav bar',);
          }
          return const Scaffold(
            body: Center(
              child: Text(
                'Check Named Route',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
          );
        }
    );
  }
}