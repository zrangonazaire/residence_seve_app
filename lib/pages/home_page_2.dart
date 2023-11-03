import 'package:flutter/material.dart';
import 'package:residence_seve_app/components/list_home_image_widget.dart';
import 'package:residence_seve_app/constants.dart';

double collapasableHeight = 0.0;
Color select = Colors.black54;
Color notSelected = Colors.orange;

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar:   const MenuWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
         
       Container(
        color: Colors.white,
        height: size.height,
        child: const     ListImageGridViewWidget()),
          ],
        ),
      ),
    );
  }
}
