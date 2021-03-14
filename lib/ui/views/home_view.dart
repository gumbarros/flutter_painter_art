import 'dart:ui';
import 'package:flutter_painter_art/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../home_painter.dart';

class HomeView extends StatelessWidget {
  final double iconSize = Get.height * 0.03;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) => Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.blue[900],
                      Colors.blue,
                  Colors.white,

                ])),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: Get.width,
                    height: Get.height * 0.085,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          iconSize: iconSize,
                          onPressed: _.clearScreen,
                        ))),
                RepaintBoundary(
                  key: _.key,
                  child: Container(
                    width: Get.width * 0.95,
                    height: Get.height * 0.80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4))]),
                    child: GestureDetector(
                        onPanDown: _.setPoints,
                        onPanUpdate: _.setPoints,
                        onPanEnd: _.setPoints,
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            child: CustomPaint(
                                painter: HomePainter(
                                    points: _.points,
                                    color: _.selectedColor,
                                    strokeWidth: _.selectedStrokeWidth)))),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    width: Get.width * 0.95,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.color_lens,
                            color: _.selectedColor == Colors.white ? Colors.black : _.selectedColor,
                          ),
                          onPressed: _.showColorDialog,
                          iconSize: iconSize * 1.2,
                        ),
                        Expanded(
                            child: Slider(
                          min: 0.5,
                          max: 7,
                          inactiveColor: _.selectedColor == Colors.white
                              ? Colors.black.withOpacity(0.1)
                              : _.selectedColor.withOpacity(0.1),
                          activeColor:
                              _.selectedColor == Colors.white ? Colors.black : _.selectedColor,
                          value: _.selectedStrokeWidth,
                          onChanged: _.setSelectedStrokeWidth,
                        )),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.eraser),
                          onPressed: _.eraser,
                          iconSize: iconSize,
                        ),
                        Visibility(
                          visible: GetPlatform.isMobile,
                          child: IconButton(
                            icon: Icon(Icons.save),
                            onPressed: _.save,
                            iconSize: iconSize,
                          ),
                        )
                      ],
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}